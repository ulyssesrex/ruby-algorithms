=begin

From https://www.hackerrank.com/challenges/angry-professor
	
A Discrete Mathematics professor has a class of N students. Frustrated with
their lack of discipline, he decides to cancel class if fewer than K students
are present when class starts.

Given the arrival time of each student, determine if the class is canceled.

Input Format:

The first line of input contains T, the number of test cases.

Each test case consists of two lines. The first line has two space-separated
integers, N (students in the class) and K (the cancelation threshold). The
second line contains N space-separated integers (a{1}, a{2}, …, a{N}) describing the
arrival times for each student.

Note: Non-positive arrival times (a{i} ≤ 0) indicate the student arrived early or
on time; positive arrival times (a{i} > 0) indicate the student arrived a{i} minutes
late.

Output Format:

For each test case, print the word YES if the class is canceled or NO if it is
not.

Constraints:

    1 ≤ T ≤ 10 
    1 ≤ N ≤ 1000 
    1 ≤ K ≤ N 
    −100 ≤ a{i} ≤ 100,
    where i ∈ [1,N]

Note: 

If a student arrives exactly on time (a{i} = 0), the student is considered to
have entered before the class started.
	
=end

def get_test_cases_number
	gets.strip.to_i
end

def get_line
	gets.strip.split(" ").map(&:to_i)
end

def result_value(threshold_value, arrival_times_array)
	 students_on_time(arrival_times_array) >= threshold_value ? "YES" : "NO"
end

def students_on_time(arrival_times_array)
	arrival_times_array.select { |time| time <= 0 }.length
end


test_cases = get_test_cases_number
test_cases.times do
	threshold_value = get_line.last
	arrival_times   = get_line
	puts result_value(threshold_value, arrival_times)
end