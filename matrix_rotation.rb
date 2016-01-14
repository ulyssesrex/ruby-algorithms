=begin

Matrix Rotation Problem

https://www.hackerrank.com/challenges/matrix-rotation-algo

You are given a 2D matrix, a, of dimension MxN and a positive integer R. You
have to rotate the matrix R times and print the resultant matrix. Rotation
should be in anti-clockwise direction.

It is guaranteed that the minimum of M and N will be even.

Input Format: 

First line contains three space separated integers, M, N and R,
where M is the number of rows, N is number of columns in matrix, and R is
the number of times the matrix has to be rotated. Then M lines follow, where
each line contains N space separated positive integers. These M lines
represent the matrix.

Output Format: 

Print the rotated matrix.

Constraints: 

2 <= M, N <= 300 
1 <= R <= 10^9 
min(M, N) % 2 == 0 
1 <= a{ij} <= 10^8, where i ∈ [1..M] & j ∈ [1..N]

Accepts STDIN string in format 'N{1} N{2} N{3}'
and returns array of integers.

=end

def gets_integers
	gets.strip.split(" ").map { |n| n.to_i }
end

params_input = gets_integers

# rows_n      = params_input[0]
# columns_n   = params_input[1]
# rotations_n = params_input[2]

def parameters(params_input)
	p = {}
	p[:rows_n]      = params_input[0]
	p[:columns_n]   = params_input[1]
  p[:rotations_n] = params_input[2]
  p
end

def smallest_axis_length(parameters)
	if parameters[:rows_n] < parameters[:columns_n]
		parameters[:rows_n]
	else
		parameters[:columns_n]
	end
end
# smallest_axis_n = rows_n < columns_n ? rows_n : columns_n
def circles_max(parameters)
	smallest_axis_length / 2
end

# circles_max = smallest_axis_n / 2

matrix = []
parameters[:rows_n].times do |n|
	row = gets.strip.split(" ")
	matrix << row
end

circle_index = 0
matrix_size  = rows_n * columns_n

circles = []
indices = []
while circle_index < circles_max
	circles << []
	pad = circle_index
	row = col = 0 + pad
	while matrix[row + pad + 1]
		circles.last << matrix[row][col]
		indices << (row * columns_n) + col
		row += 1
	end
	while matrix[row + pad][col + pad + 1]
		circles.last << matrix[row][col]
		indices << (row * columns_n) + col
		col += 1
	end
	while row - pad > 0
		circles.last << matrix[row][col]
		indices << (row * columns_n) + col
		row -= 1
	end
	while col - pad > 0
		circles.last << matrix[row][col]
		indices << (row * columns_n) + col
		col -= 1
	end
	circle_index += 1
end

circles.each do |circle|
	circle.rotate!(-rotations_n)
end

circles.flatten!

rotated_matrix = Array.new(matrix_size)
i = 0
while i < matrix_size
	rotated_matrix[indices[i]] = circles[i]
	i += 1
end

rotated_matrix.each_slice(columns_n) do |slice|
	puts slice.join(" ")
end