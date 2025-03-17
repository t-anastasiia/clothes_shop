import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Тестируем API
        Task {
            await NetworkTest.testProductAPI()
        }
        
        // ... rest of your scene setup code ...
    }

    func sceneDidDisconnect(_ scene: UIScene, willBeRemoved: Bool) {
        // Called when the scene is being removed from its parent.
        // This occurs when the scene is being removed from the task manager.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene is being presented to the user.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene is being removed from an active state to an inactive state.
        // This may occur when the user is transitioning between apps.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called when the scene is being presented to the user.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called when the scene is being removed from an active state to an inactive state.
        // This may occur when the user is transitioning to the background or when the scene is being terminated.
        // Save data, release shared resources, and store enough scene-specific state information
        // to restore the scene when it's being re-created.
        // If any sessions are being discarded or being re-created, the scene may not be re-created when the scene is being re-created.
 