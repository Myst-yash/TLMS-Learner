import Foundation

class CentralState{
    static let shared = CentralState()
    var enrolledCourse = [String]()
    
    func updateEnrolledCourse(arr:[String]){
        self.enrolledCourse = arr
    }
    
    func checkIfEnrolled(id:String) -> Bool{
        for i in enrolledCourse{
            if i == id {
                return true
            }
        }
        return false
    }
}
