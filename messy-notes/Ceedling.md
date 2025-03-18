## Ceedling unit test framework

#### Resources

[Everything on GitHub (Mark VanderVoord)](https://github.com/mvandervoord)

[Forums](http://www.throwtheswitch.org/forums)

[James W. Grenning, *TDD for Embedded C*, home page](https://pragprog.com/book/jgade/test-driven-development-for-embedded-c)

[Author's (JWG) guide](https://github.com/jwgrenning/tddec-code). Use installation instructions; raw code taken from [here](https://pragprog.com/titles/jgade/source_code); [adapted code](https://github.com/Tyrn/jwg-code)

[James Grenning's site](https://www.wingman-sw.com/about)

[Ceedling example](https://github.com/dimonomid/test_ceedling_example); [some more, in Russian](http://proiot.ru/blog/tag/cmock/)

[CMock docs on GitHub](https://github.com/ThrowTheSwitch/CMock/blob/master/docs/CMock_Summary.md)

[CMock Under the Hood](http://vandervoord.net/blog/2015/5/31/cmock-under-the-hood-part-1-memory) (2 parts)

[Mocking Embedded Hardware Interfaces with Ceedling and CMock](http://www.electronvector.com/blog/mocking-embedded-hardware-interfaces-with-ceedling-and-cmock)

[Add unit tests to your current project](http://www.electronvector.com/blog/add-unit-tests-to-your-current-project-with-ceedling)

[Ceedling docs on GitHub](https://github.com/ThrowTheSwitch/Ceedling/blob/master/docs/CeedlingPacket.md), [**Eclipse** (semi)official](http://www.throwtheswitch.org/eclipse/), [Eclipse](http://www.electronvector.com/blog/add-unit-tests-to-your-current-project-with-ceedling), [YAML](https://en.wikipedia.org/wiki/YAML), [Dmitry Frank](https://dmitryfrank.com/articles/unit_testing_embedded_c_applications)

#### Eclipse integration

- Install Ceedling:
```
$ gem install ceedling
```
- Create Ceedling project (troubleshooting [#215](https://github.com/ThrowTheSwitch/Ceedling/pull/215)):
```
myproject $ cd ..
$ ceedling new myproject
$ cd myproject/vendor/
$ rm -rf ceedling/
$ git clone --recursive https://github.com/throwtheswitch/ceedling.git # No longer needed.
```
- Modify `vendor/ceedling/plugins/module_generator/config/module_generator.yml`:
```
:module_generator:
  :project_root: ./
  :source_root:  Src/
  :inc_root:     Inc/
  :test_root:    test/
```
- Modify `project.yml`([sample](https://github.com/Tyrn/stmbox/blob/master/project.yml)):
```
...
:paths:
  :test:
    - +:test/**
    - -:test/support
  :source:
    - Src/**
  :include:
    - Drivers/**
    - Inc/**
  :support:
    - test/support
...
:defines:
  :commmon: &common_defines  # A nice typo, next to invisible :)
    - STM32F103xB
...
:cmock:
  :strippables:
    - volatile
...
 :plugins:
  :load_paths:
    - vendor/ceedling/plugins
  :enabled:
#    - stdout_pretty_tests_report
    - stdout_gtestlike_tests_report
    - module_generator
```

##### Eclipse C/C++ Unit plugin

*Unit plugin is available only in Release configuration!*

- Main/Project: `myproject`

- Main/Application: `/home/user/.gem/ruby/2.6.0/bin/ceedling`

- Main/Disable auto build

- Arguments/Program arguments: `clobber\ntest:all`

- Testing/Test Runner: `Google Test Runner`

- Environment: Variable `TERM` Value `xterm`


#### Usage
##### Commands

- `$ ceedling help`

- `$ ceedling help module`

##### Expect
Conditional statements and loops is actually where CMock really starts to shine over just creating stubs. The idea is that you would write multiple tests to capture the different behaviors (paths) through a function. In each individual test function, you would concentrate on one path.

For example, let's say you have a function like this:
```
void simple_decider(int a)
{
    if (a > get_magic_number() )
        do_greater_thing(a);
    else
        do_lesser_thing(a);
}
```
We have two paths through this function, so most likely we're going to want at least two tests (possibly more with the weird control logic we have here). One might look like this:
```
void test_simple_decider_should_do_greater_thing_when_given_greater_than_magic(void)
{
    get_magic_number_ExpectAndReturn(5);
    do_greater_thing_Expect(a);

    simple_decider(6);
}
```
and the next test might look something like this:
```
void test_simple_decider_should_do_lesser_thing_when_given_lesser_than_magic(void)
{
    get_magic_number_ExpectAndReturn(5);
    do_lesser_thing_Expect(a);

    simple_decider(4);
}
```
SImilarly, loops can be tested well with CMock too. Not only can you inject responses to functions as we did above, you can queue up as many expectations to a function as you want. Since you're in control of all the things that come in and out of functions, you can specify how many times through a loop a test should handle.

Like this beauty:
```
int looper(void)
{
    int count = 0;
    while (keep_looping()) {
        do_stuff(count++);
    }
    return count;
}
```
Could have tests that look something like these:
```
void test_looper_should_handle_zero_loops(void)
{
    keep_looping_ExpectAndReturn(0);

    TEST_ASSERT_EQUAL(0, looper());
}

void test_looper_should_handle_multiple_loops(void)
{
    keep_looping_ExpectAndReturn(1);
    do_stuff_Expect(0);

    keep_looping_ExpectAndReturn(1);
    do_stuff_Expect(1);

    keep_looping_ExpectAndReturn(1);
    do_stuff_Expect(2);

    keep_looping_ExpectAndReturn(0);

    TEST_ASSERT_EQUAL(2, looper());
}
```
Of course, there are times that your conditionals and your loop variables are NOT directly related to the data you are passing into the function and/or data being returned from a mock. They could be the results of calculations, internal counters, etc. Most often, these will be fairly obvious how to test once you get the hang of it... but occasionally you'll get a troublesome one. Perhaps the hardest situation is where someone is using a static variable inside their function, so that a call to the function depends in some way on previous calls. For example this:
```
int mystery_summer(int a)
{
    static int b = 0;
    b += a;
    return b;
}
```
For this, instead of writing multiple tests, you'd want to write one. Multiple tests implies that they are all self-contained and shouldn't depend on one another.
```
void test_mystery_summer_just_keeps_adding(void)
{
    TEST_ASSERT_EQUAL(7, mystery_summer(7) );
    TEST_ASSERT_EQUAL(16, mystery_summer(9) );
    TEST_ASSERT_EQUAL(20, mystery_summer(4) );
    TEST_ASSERT_EQUAL(2, mystery_summer(2) );
    TEST_ASSERT_EQUAL(222, mystery_summer(200) );
}
```
If another test actually needed to use this function, it would have to depend on the previous value left by the other test... which isn't ideal. This could be a good place to refactor your code. If you made "b" into a static module variable it would give you the same benefits... and it would give you the ability to add a function to reset it when you needed to from a test (or even release code if you later need that).

Now I didn't actually use CMock in that example, nor did it have multiple paths... but it gets the point across, I think? 

Does this actually answer your question?

*Mark VanderVoord*