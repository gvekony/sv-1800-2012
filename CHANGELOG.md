# Change Log (Functional Changes)
## [1.0.2]
* Corrected indent pattern on open curly braces
* Added special formal types to parenthesis (sequence, untyped)
* Fixed attribute bug in always(*) constructs
* Added operators to covergroup body (iff operator)
* Added nettype user defined type
* Added property and sequence to clocking block

## [1.0.1]
### License information and screenshots are added

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