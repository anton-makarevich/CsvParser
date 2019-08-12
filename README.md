# About the assignment

**iOS**

The assignment has been done using MVVM pattern (with flow coordinator) using only stable technologies we can use in production. (no beta stuff like SwiftUi or Combine)

The app has 2 pages: the main page displaying the list of people with issues and detail page showing extra information (birthday). Initial idea was to have just one page with 2 lines in the cell, but bithdays seems to be a secondary item for the app (which I suppose should show the number of issues by users) so I decided to move it to details page.

MVVM structure (mostly `Common` folder) was copied from the template I created earlier and used in some previous projects. 
`Services` and `Scenes` are parts related to assignment business logic and UI and were developed from scratch using TDD. UI parts (ViewControllers and Cells) are not covered by tests (even though it's possible it doesn't add any additional value as there is no actual code (only assigning of values from viemodels))

*Profiles ViewController*
- Dispalys the list of profiles in tableview using generic DataSource (could be reused for any data).
- Handles profile selection by user. 

The simplest approach is used for data binding as using RxSwift could be overkill for such a small task.

*Profile ViewCell*
- Dispalys name and number of issues for every profile on the list

No databindng is used as data is static and not going to change.

*Profiles ViewModel*
- Fetches profiles data from ProfilesService and pass it to ViewController to be displayed

*Profile ViewModel*
Wrapper around Profile data model. 
- Prepares/formats data to be displayed by Cell and Details page (the same viewmodel is reused for both)

*Profile ViewController*
- Displays person's name (in title), issues count and birthday 

*Profiles coordinator*
- Handles navigation

*Profiles Service*
- Provides profile data to viewmodel. First it checks for cached data availability (using CchingService) and returns it if available. If cache is not there then ProfilesService reads (using TextFileReadingService) csv file and parses data (using CsvParserService)

Service returns data asyncronyously to not block UI thread

*Caching Service*
- Saves profile data locally to not parse csv file every time

Current implementation uses the simplest possible approach - the servce is just a wrapper around UserDefaults as stores json serialized array of profiles, but if needed the same service could be implemented in many other ways (CoreData, SQLite, Realm etc)

Not covered with tests as it's basicly just a wrapper around iOS functionality

*Text File Reader Service*
- Reads plain text data of csv file

Current inplementation just reads file included in app bundle. But again a lot of different implementations are possible, depends on where our file is located (in bundle, somewhere on device or maybe in the internet) 

Not covered with tests as it's basicly just a wrapper around iOS functionality

*Csv parsing service*
- Takes plain csv data as string, validates it, parses and returns a list of profiles

Only core functionality is implemented, it's not reliable and couldnt be used for generic purpose (for example it breaks if one of the entries is a string containig comma)


**Android**

If needed Android app (in kotlin) can be implemented using exactly the same approach.