import Foundation

protocol ObjectLoader: class {
    func objects<T:AnyObject>(fromFile path: String, ofType ext: String) -> Array<T> where T: Decodable
}

extension ObjectLoader {
    
    func objects<T:AnyObject>(fromFile path: String, ofType ext: String) -> Array<T> where T: Decodable {
        let bundle = Bundle(for: type(of: self))
        let resourcePath = bundle.url(forResource: path, withExtension: ext)!
        
        let data = try! Data(contentsOf: resourcePath, options: .mappedIfSafe)
        let object = try! JSONDecoder().decode(Array<T>.self, from: data)
        
        return object
    }
}
