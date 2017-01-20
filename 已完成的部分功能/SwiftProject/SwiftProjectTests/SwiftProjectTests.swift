//
//  SwiftProjectTests.swift
//  SwiftProjectTests
//
//  Created by LTHJ on 2017/1/11.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import XCTest
@testable import SwiftProject
@testable import Alamofire
@testable import ObjectMapper

class SwiftProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTojson() {
        let main = MainViewController()
        main.requestClassify()
        
    }
    
    func testRequestBook() -> Void {
        //let book = BookViewController()
        //book.requestForBookList()
        let book = RequestBook()
        book.id = 10
        book.rows = 20
        book.page = 1
        
        print(book.toJSON())
    }
    
    func testRequestInAlamofire() {
        let url = "http://www.tngou.net/api/book/list"
        let urlString = "http://www.tngou.net/api/book/classify"
        Alamofire.request(urlString).responseJSON { response in
            
            
            if response.result.isSuccess{
                 print(response.result.value ?? "testttt")
            }
            
            if response.result.isFailure{
                  print("\(response.result.error)")
            }
            
          
           
        }
    }
    
    func testRequestBookToo() {
        let urlStr = "http://www.tngou.net/api/book/classify"
        let request =  Alamofire.request(urlStr)
        print("\(request.request?.httpMethod)")
        
        Alamofire.request(urlStr).responseObject { (response: DataResponse<Subject>) in
            
            guard let bookList = response.result.value  else {return}
            print(bookList.status ?? false)
            
            
        }
    }
    
    
    func testArrayMap() {
        let array = [2, 3, 5, 6]
        var anotherArray = array.map {
            return $0 + 1
        }
        
        anotherArray = array.flatMap{
            return $0 + 1
        }
        
        for i in anotherArray{
            print(i)
        }
        
    }
    
    func testErrorCatch() {
        let dog = Dog(name: "小白3", age: 21)
        var string: String!
        
        do {
            try string = dog.printDogMsg(dog: dog)
        } catch  {
            switch error {
            case DogError.NameInvalidError:
                print("dog name error")
            case DogError.NameLengthError:
                print("dog name length error")
            case DogError.AgeInvaildError:
                print("dog age invaild error")
            default:
                print("No implicit error")
            }
        }
        
    }
    
    
    func testArraySlice() {
        let array = [1, 2, 3]
        
        let result = ArraySlice(array)
        
        for i in result{
            print(i)
        }
        
    }
    
    
}
