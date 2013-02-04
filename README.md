ruby-doxygen-parser
================

Ruby library that uses Doxygen XML output to parse and query C++ header files.

Using Doxygen allows us to parse even a set of non-compilable include files.
 
This is very useful in case you need to parse only a subset of a big library which doesn't compile because of being incomplete or needing configuration through Makefiles, CMake, etc. In those cases parsing with gccxml, swig or others would throw lots of compilation errors

This library is based on Nokogiri (http://nokogiri.org/) and takes as input the xml 

Work is ongoing (specially testing!!) so you will eventually find bugs. You are encouraged to improve this library at anytime!!

No much documentation so far :( but I hope it will change in the next days ;)


Use Examples:

# Creates a namespace object
namespace=DoxyNamespace.new(:name=> "MyNamespace",:dir=>File.expand_path("/path/to/doxygen/generated/xml-directory"))

# Reference to the doxygen generated XML file with the description of the namespace
puts namespace.path # >/path/to/doxygen/generated/xml-directory/namespaceMyNamespace.xml

# Parses the related XML file. Note it is done lazily and noy at object creation
namespace.parse

# Returns namespace functions
functions=namespace.get_functions # Also get_functions ["function1",...]

# Returns namespace enums
enums=namespace.get_enums # Also get_enums ["function1",...]

# Returns all the namespace classes
classes=namespace.get_classes

# Returns only some selected classes
classes=namespace.get_classes ["MyNamespace::Class1", "MyNamespace::Class2", "MyNamespace::Class3", "MyNamespace::Class4"]

class1=classes[0]

# Returns class properties
puts class1.parent.name # >MyNamespace
puts class1.name # > MyNamespace::Class1
puts class1.prot # > "public"

# Reference to the doxygen generated XML file with the description of the class
puts class1.path # >/path/to/doxygen/generated/xml-directory/classMyNamespace_1_1Class1.xml

# Returns class' inner-classes
innerclasses=class1.get_classes # Also get_classes ["innerclass1",...]

# Returns class' variables
vars=class1.get_variables # Also get_variables ["var1",...]

# Returns class' include file
file = class.get_file

puts file.name # >myIncludeFile.h
puts file.path # >/path/to/doxygen/generated/xml-directory/myIncludeFile_8h.xml

# Returns other classes also included in the same file
other_classes = file.parse.get_classes


# Returns class' methods
methods=class1.get_functions # Also get_functions ["function1",...]


myMethod=class1.get_functions(["myMethod"])[0]

# Returns Function properties
puts myMethod.name # > myMethod
puts myMethod.parent.name # > MyNamespace::Class1
puts myMethod.path # > /path/to/included/file/myIncludeFile.h:245
