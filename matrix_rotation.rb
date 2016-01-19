=begin

Matrix Rotation

From https://www.hackerrank.com/challenges/matrix-rotation-algo

You are given a 2D matrix, a, of dimensions (MxN) and a positive integer R. You
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

class MatrixParameters
	attr_accessor :rows, :columns, :rotations

	def initialize(parameters_array)
		@rows, @columns, @rotations = *parameters_array		
	end
end

class MyMatrix < Array
	def initialize(two_dimensional_array)
		@matrix  = two_dimensional_array
		@rows    = two_dimensional_array.length
		@columns = two_dimensional_array.first.length
		@entries = @rows * @columns
	end

	def rotate(rotations_n)
		ring_levels = (0..ring_level_max(@rows, @columns))
		indices = []
		values  = []
		ring_levels.each do |level|
			ring_indices = self.outer_ring(level, indices_only: true)
			indices.push(ring_indices)
			ring_values = self.outer_ring(level)
			rotated_values = ring_values.rotate(-rotations_n)
			values.push(rotated_values)
		end
		indices.flatten!; values.flatten!
		rotated_matrix = []
		@entries.times do |index|
			rotated_matrix[indices[index]] = values[index]
		end
		rotated_matrix
	end

  # Returns a ring of values (array), from a 2D matrix, at specified level.
  # 'Level' refers to how deeply the ring is nested inside other rings.
  # If @matrix = 
  # [[ 2,  3,  5,  7], 
  #  [11, 13, 19, 23],
  #  [29, 31, 37, 41],
  #  [43, 47, 53, 59],
  #  [61, 67, 71, 73]]
  # then
  # @matrix.outer_ring(0) => [2, 11, 29, 43, 61, 67, 71, 73, 59 ... etc]
  # @matrix.outer_ring(1) => [13, 31, 47, 53, 37, 19]
  # @matrix.outer_ring(2) => []
	def outer_ring(level, indices_only: false)
		aggregator = []
		current_row = current_column = offset = level
		while aggregator.length < ring_circumference(level)
			index = current_row * @columns + current_column
			value = @matrix[current_row][current_column]
			aggregator.push(indices_only ? index : value)
			case ring_side(current_row, current_column, level)
			when :left
				current_row += 1
			when :bottom
				current_column += 1
			when :right
				current_row -= 1
			when :top
				current_column -= 1
			end
		end
		aggregator
	end

	private

	def ring_level_max(rows, columns)
		[rows, columns].min / 2 - 1
	end

	def number_of_entries(rows, columns)
		rows * columns
	end

	def ring_side(row, column, ring_level)
		case
		# When on left side but not on bottom
		when column - ring_level <= 0 && row + ring_level + 1 < @rows
			:left
		# When on bottom but not on right side
		when row + ring_level + 1 >= @rows && column + ring_level + 1 < @columns
			:bottom
		# When on right side but not on top
		when column + ring_level + 1 >= @columns && row - ring_level - 1 >= 0
			:right
		# The top side remains
		else
			:top
		end			
	end

	def ring_circumference(level)
		((@rows - 2 * level) * 2) + (2 * ((@columns - 2 * level) - 2))
	end
end

def get_line
	gets.strip.split(" ").map(&:to_i)
end

def get_matrix(parameters_object)
	matrix = []
	parameters_object.rows.times do
		matrix << get_line
	end
	matrix
end

def put_matrix(matrix, row_length)
	matrix.each_slice(row_length) do |row|
		puts row.join(" ")
	end
end

params_array = get_line
parameters   = MatrixParameters.new(params_array)

matrix_data = get_matrix(parameters)
row_length  = parameters.columns
my_matrix   = MyMatrix.new(matrix_data)

rotations = parameters.rotations
rotated_matrix = my_matrix.rotate(rotations)

put_matrix(rotated_matrix, row_length)