
// Helper function 
import Foundation
public func executeProcedure(for description:String, procedure: () -> Void){
    print("Procedure executed for:", description)
    procedure()
}

// Extension on Int to check if a number is prime or not
public extension Int {
    
    func isPrime() -> Bool {
        guard self > 1 else { return false }
        
        var isPrimeFlag = true
        
        for index in 2..<self {
            if self % index == 0 {
                isPrimeFlag = false
            }
        }
        
        return isPrimeFlag
    }
}
