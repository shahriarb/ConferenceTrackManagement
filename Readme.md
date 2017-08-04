# Conference Track Management:

## Archive Structure:

Archive file contains three folders :
* **app:** Contains source code of application
* **data:** Contains sample data
* **test:** Contains unit tests for source codes

## How to run

1. Unzip the _archive file_ into a path.
2. Go the path
3. Run `ruby app/app.rb path_to_the_input_data_file`

If you don't provide an input file, source code will use `data/base_input.txt` as input data, which is the sample provided by ThoughtWorks.
So to get a sample output just unzip the archive, go the path and run `ruby app/app.rb`

## How to test

Test units are present in _test_ folder. 

To run a single test:
1. Unzip the _archive file_ into a path.
2. Go the path
3. Run `ruby test/test_unit_you_want_to_run`  i.e `ruby test/talk_parser_test.rb`

To run all test together:
1. Unzip the _archive file_ into a path.
2. Go the path
3. Run `find test/ -name '*_test.rb' | xargs -n1 -I{}  ruby -Itest {}`

## Design

App will receive an input file as an argument which will be passed to __InputFileReader__ class. Without any argument App will assume `data/base_input.txt` as its input data.

__InputFileReader__ reads the file - line by line - and passes each line to __TalkParser__  class which will parse the line and create a __Talk__ object if input is valid or an error containing the line number and description of the error.
If number of errors is more than 2, __InputFileReader__ will stop processing and return errors to main application.

There is a class called __OutputHandler__ which is responsible to format the output. In case of parse errors, main application will use __OutputHandler__ to show formatted output to the user.    

If __InputFileReader__ can parse input file successfully we will have an array containing __Talk__ objects which each of them has a _title_ and a _duration_ attribute.

After parsing input data, main application uses __ConferenceFactory__ to create a bare conference.  _ConferenceFactory.new_conference_ method will create a __Conference__  object and add __Track__ objects to it.

Each __Track__ has a _morning_session_ and _afternoon_session_. 

A _morning_session_ is an object of __Session__ class which has _stat_time_, _end_time_  and an array of __Talks__.  Also there are three other methods responsible to show the status of this session: _current_length_, _max_length_  and _is_full?_.  To add a _talk_ to a _session_, caller can use _add_talk_ method. This method will try to add the talk and return the operation result. _True_ if operation is succesfull and _false_ if there is not enough room left in session to add the talk.

An _afternoon_session_ is an __OpenEndSession__ which is a subclass of __Session__.  This class has a new attribute called _soft_end_time_ which will help it to have a flexible end of session. Also this class will override _is_full?_ method of its parent to use _soft_end_time_ attribute to calculate if the session is full.
  
After __ConferenceFactory__  created a bare class, we will pass it with _input_talks_ to __ConferencePlanner__ object to find a successful plan.
__ConferencePlanner__ will calculate different permutation of its input-list and for each permutation tries to fit all talks in sessions of conference. 
To do this it will choose an starting point in permutation and tries to add each talk sequentially into sessions. If in the middle of sequence a talk can not be added to any session, it means we can not use this permutation with this starting point, so we will going to try another starting_point in permutation.

__ConferenceFactory__ will use [Factorial](https://en.wikipedia.org/wiki/Factorial_number_system#Permutations) to generate all permutations. If any permutation with any starting point can fit into all sessions, __ConferencePlanner__ will return the result to main application and main application will use __OutputHandler__ to deliver the result to end user. 




