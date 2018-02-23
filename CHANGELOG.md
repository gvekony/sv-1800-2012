# Change Log
## [1.0.0]
### Initial release
#### The addon supports the following features
* classes
* comments, attributes, various conventional highlights (accessors, numbers, etc.)
* constraint blocks
* coverage
* interfaces
* modules
* packages
* tasks and functions

#### Limited support on the following features
* checkers
* programs
* user-defined primitives
* UVM related classes, types, macros and functions

#### Unsupported features and problems
* specify blocks
* Logical '<=' and the assignment '<=' are not differentiated yet. Solution: logical operators shall only be applied inside of a parenthesis.(?)
* A.1.2: SystemVerilog source text: { package_import_declaration } in module_nonansi_header, module_ansi_header is not supported.