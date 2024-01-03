# 목차
1. [Coordinator Pattern](#Coordinator-Pattern)
2. [Coordinator 구현하기](#구현하기)
    - CoordinatorProtocol
    - Coordinator
    - Flow 생성하기
    - Coordiantor 종료하기
3. [고민한 점](#고민한-점)
    - [Deep 이벤트 처리 문제](#Deep-이벤트-처리-문제)
    - [FlowResponder](#Flow-Responder)
    - [UIResponder를 활용하지 않은 이유](#UIResponder를-활용하지-않은-이유)
  
# 브랜치 참고
- **start**: defaultCoordinator [브랜치 이동하기 ➡️](https://github.com/yjjem/CoordinatorPattern/tree/defaultCoordinator)
- TabBarCoordinator [브랜치 이동하기 ➡️](https://github.com/yjjem/CoordinatorPattern/tree/tabCoordiantor)
- **final**: TabBarCoordinator + FlowResponder [브랜치 이동하기 ➡️](https://github.com/yjjem/CoordinatorPattern/tree/flowResponder)

# Coordinator Pattern
**Coordinator**는 ViewController로 부터 유저 흐름 제어 로직을 분리해 관리한다. 코드가 비대해지는 문제점들을 해소해줄 수 있다.

Boostrap 설정들로 채워지기 쉬운 AppDelegate와 SceneDelegate로부터 설정 로직을을 분리하고 RootCoordinator에서 관리한다. AppDelegate와 SceneDelegat가 LifeCycle 처리에 집중할 수 있게 해준다. 

Massive ViewController 문제도 해소해준다. 유저의 흐름은 Coordiantor가 처리하고 컨텍스트도 직접 설정한다. ViewController는 컨텍스트에 대한 정보 그리고 다른 ViewController에 대한 의존성이 없기 떄문에 재사용에 용이하다.

# 구현하기
### 1. Coordinator protocol 추가하기
우선 기본 인터페이스를 정의해주어야한다. Flow를 시작하는 `start()` 메서드와 `childCoordinators` 변수가 필요하다.</br>
`star()` 메서드에서 기본 flow를 설정하고 실행되고 메모리에서 해제되기 때문에 참조를 `childCoordinators` 관리할 collection 변수가 필요한 것이다.

```swift
protocol Coordinator {
    var childCoordinators: [UUID: Coordinator] { get set }
    var identiier: UUID { get }
    func start()
}
```

### 2. Coordinator 구현하기
RootCoordinator를 예시로 들었다. 하지만 일반적인 Coordinator와 구현은 크게 다르지 않다. 다만 RootCoordinator는 앱을 제어하는 최상단 Coordinator이기 때문에 window를 설정하고 관리한다.. AppCoordinator를 구현하면 된다. 멀티태스킹을 지원한다면 SceneCoordinator를 추가하면 된다.

```swift
final class SceneCoordinator: Coordinator {
    var childCoordinators: [UUID: Coordinator] = [:]
    let identifier: UUID = .init()

    private let window: UIWindow
    private let navigationController: UINavigationController = .init()

    init(window: UIWindow) {
        self.window = window
    }

    func start() { ... }
}
```

### 4. Flow 생성하기
Coordinator에서 보여줄 flow를 private 메서드에 구현한다. Flow(Coordinator, ViewController)의 초기화는 이곳에서 수행하면 된다.

```swift
private func showAuthFlow() {
    let authCoordinator = AuthCoordinator(navigationController: navigationController)
    authCoordinator.delegate = self
    authCoordinator.start()
}
```

### 5. Coordinator 종료하기
유저가 이전 흐름으로 돌아가려한다면 현재 Coordinator를 종료시켜야한다. <br/>
Delgate 패턴을 활용해 이벤트를 전달하고 메모리에서 해제될 수 있도록 `removeChild`를 해주면 된다.

```swift
protocol SomeCoordinatorFinishDelgate {
    func didFinish(_ coordinator: Coordinator)
}
```

```swift
extension RootCoordinator: SomeCoordinatorFinishDelgate {
    func didFinish(_ coordinator: Coordinator) {
        removeChild(coordinator: coordinator)
    }
}
```

# 고민한 점
## Deep 이벤트 처리 문제
> <image src="https://github.com/yjjem/CoordinatorPattern/assets/88357373/8cd7a12d-f2ad-43e3-8da5-2ff4748e0ef0" height="230"/>

최하단 Coordinator에서 발생한 이벤트를 최상단에서 어떻게 처리할까. Profile 뷰에서 발생하는 로그아웃 이벤트를 예시로 들어보겠다. Profile뷰를 관리하는 코디네이터가 `delegate?.didFinishWithLogOut()` 를 호출하고 계층에 따라 촤상단에 도달할 때 까지 delegate로 연결해야한다.
로그아웃 관련 처리를 직접 하지 않는 Coordinator들도 이 컨텍스트의 delegate 메서드 또는 프로토콜을 추가해야한다.

> 단 하나의 이벤트를 위해 새로운 프로토콜이나 메서드들을 구현해야한다. 

### Flow Responder
문제를 해결하기 위해 FlowResponder를 구현했다. Coordiantor를 위한 ResponderChain을 구현했다고 이해하면 된다.

```swift
class FlowResponder: NSObject {
    private weak var nextFlowResponder: FlowResponder?

    func sendFlowEvent(_ selector: Selector) {
        if responds(to: selector) {
            perform(selector)
        } else {
            nextFlowResponder?.sendFlowEvent(selector)
        }
    }
    
    func setNext(flowResponder: FlowResponder) {
        self.nextFlowResponder = flowResponder
    }
}
```

Coordinator가 FlowResponder를 상속하도록 하고 `addChild` 를 하면서 next setNext지정을 해주면 된다.
```swift
extension CoordinatorProtocol {
    func addChild(coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.setNext(flowResponder: self)
    }
```

### UIResponder를 활용하지 않은 이유
UIResponder를 활용해 이벤트를 처리할 수는 있다. 하지만 무조건 AppDelegate를 거쳐야하고 RootCoordinator에 전달되어야한다. 이벤트 처리 주체가 중간에 있다면 RootCoordinator부터 중간 Coordinator까지 또 전달해야한다. FlowResponder를 사용하면 원하는 Coordinator에 원하는 이벤트를 산지직송할 수 있다.


