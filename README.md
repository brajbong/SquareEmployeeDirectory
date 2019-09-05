EmployeeDirectory

> Focus Areas:

1. Testability
	- Single Responsibility
	- Reduce coupling
		- Have tried to granulize a use-case until it's composed of classes/ functions gelled together, where each of those classes/ functions kinda do just one thing. That way, that particular class/ function act as a "pure" one (as much as it can), and could be unit tested easily.
	- Dependency Injection
		- Instead of creating singleton network manager class etc., I have used the concept of services that can be mocked (for testing) and/or can be stacked in levels where dependent service(s) can be "injected" to classes or other services that need them.
		- Using mocks and stubs for async network testing: I have used protocol based mocking of network classes (e.g. URLSessionDataTask, URLSession) to perform network tests. At the same time, I have also utilized local JSON based approach to ensure that the interface is tested properly for all possible inputs, as per the requirement. This is helpful when only the interface between the backend and front end is ready, but we don't have a working backend yet. We still can be confident that our code will work since we have locally tested the JSON interface/ payload.

2. iOS best practices
	- Naming
	- code folder structure
	- less/ no singletons
	- immutable models
	- parameters (e.g. urls) configurable from plist
	-  less stringly typed (use enums)
	- no massive view controller 
	- Result type
	- Codable JSON parsing
	- vc only deals with view lifecycle stuff and displaying data
(in this simple case, the employee view model is an overkill but I still used it to show the structure for more complicated cases, where we might need the view model to make changes to the model/ format it to make it presentable on the view.)
2. Modular
	 - When I say modular in the context of the app, I don't mean creating different modules for business logic, UI etc. Instead, I have tried to follow it more like a loose architectural principle.
	 
3. Clean code
	- avoided using: unnecessary commenting, temp variables, bulky 3rd party cocoapods for simple use-cases.


> Improvements to be made:

1. Use flow controller/ co-ordinator (overkill for this simple use-case, so did not use.)
2. Add a crash logging framework 
3. Add an analytics framework
4. Add logging 
5. Proper artworks, icons, images etc.
6. More tests

> Copied in code or dependencies

I try to avoid external frameworks/ cocoapods etc unless those add massive value. The use-case being simple here, I did not need any 3rd party framework. 

I have used services to do network/ async data work and injecting them as dependencies in my earlier projects. I have also used network mocks through protocols before. So those were kinda reused but not really copied.

> Device Focus

App is only meant for iPhones in portrait mode at this time.

> Time Spent

Worked in small chunks for past 6 days. Estimated time spent would be 8 hours. I don't code very fast.

> Additional

Have not really tried to follow a particular architecture, such as, MVC, MVVM, MVVM-C, Viper etc. Have taken a pragmatic approach to reduce code coupling and enhance testability, which embracing ideas like view models, services instead of singleton managers, using protocols to create abstractions, injection of dependency instead of making those concrete members.


> Written with [StackEdit](https://stackedit.io/).
