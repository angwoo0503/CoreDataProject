class ProfileViewModel {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var userName: String {
        return user.userName
    }
    
    var userAge: String {
        return "\(user.userAge)"
    }
}
