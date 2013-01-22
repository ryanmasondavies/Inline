def objc_code_for_test(name, implementation)
  """
  INLTest *#{name} = [[INLTest alloc] init];
  [#{name} setName:@\"#{name}\"];
  [#{name} setBlock:^{
      #{implementation}
  }];
  [self addTestInvocation:[INLTestInvocation invocationWithTest:#{name}]];
  """
end

def objc_code_for_tests(test_attributes)
  test_code = []
  test_attributes.each do |attributes|
    implementation = ""
    unless attributes["pass"].eql? "1"
      implementation = "[[NSException exceptionWithName:SenTestFailureException reason:@\"Failed!\" userInfo:@{SenTestFilenameKey: @(__FILE__), SenTestLineNumberKey: @(__LINE__)}] raise];"
    end
    test_code << objc_code_for_test(attributes["name"], implementation)
  end
  test_code.join("\n")
end

def objc_code_for_test_case(name, test_attributes)
  """
  #import <SenTestingKit/SenTestingKit.h>
  #import <Inline/Inline.h>
  @interface SomeTests : INLTestCase; @end
  @implementation SomeTests
  + (void)initialize
  {
      #{objc_code_for_tests(test_attributes)}
  }
  @end
  """
end
