import Foundation

class CentralState{
    static let shared = CentralState()
    var enrolledCourse = [String]()
    var likedCourse = [String]()
    
    func updateEnrolledCourse(arr:[String]){
        self.enrolledCourse = arr
    }
    
    func updateLikedCourse(arr:[String]){
        self.likedCourse = arr
    }
    
    func checkIfEnrolled(id:String) -> Bool{
        for i in enrolledCourse{
            if i == id {
                return true
            }
        }
        return false
    }
    
    func unlikeCourse(id:String){
        let newArr = self.likedCourse.filter { $0 != id }
        self.likedCourse = newArr
    }
    func likeCourse(id:String) {
        self.likedCourse.append(id)
    }
    func checkIfLiked(id:String)->Bool{
        for i in likedCourse{
            if i == id {
                return true
            }
        }
        return false
    }
    
}
