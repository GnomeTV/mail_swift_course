import Foundation

protocol ILoginViewModel {
    func login()
    func register()
}

class LoginViewModel: ILoginViewModel {
    
    /**
     Сюда надо будет закидывать сервисы и общаться с ними здесь
     Вот в принципе пример какой-то архитектуры
     Здесь будет что-то типа:
     private let userService: IUserService
     
     init(userService: IUserService) {
        self.userService = userService
     }
     
     и модель будет инициализироваться в классе PresentationAssembly
     
     во ViewModel  можно пихать че угодно чтобы разгрузить ViewController
     это не Viper, в такой архитектуре нет четкого разделения ответственностей
     */
    
    func login() {
        print("Login")
    }
    
    func register() {
        print("Register")
    }
}
