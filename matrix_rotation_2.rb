class MatrixParams
	attr_accessor :rows, :columns, :rotations

	def initialize(parameters_array)
		@rows, @columns, @rotations = *parameters_array
	end
end

class MyMatrix < Array
	def initialize(number_of_rows, number_of_columns, matrix_data)
		@matrix = matrix_data
		@number_of_rows = number_of_rows
		@number_of_columns = number_of_columns
	end

	def rotate(number_of_rotations)

	end



	private

 [[lttttt],
	[lltttr],
	[llltrr],
	[lllrrr],
	[llbrrr],
	[lbbbrr],
	[bbbbbr]
]

l
ll
lll
llll
lll
ll
l
x

	ltttt
	llttr
	lbbrr
	bbbbr

	def number_of_entries
		@number_of_rows * @number_of_columns
	end

	def left_indices
		l_indices = []
		left_rows = @number_of_rows - 1
		adjusted_center = left_rows / 2.0 - 1
		row_index = 0
		number_of_indices = 1
		while row_index < left_rows && number_of_indices > 0
			l_indices.push(*self[row_index][0, number_of_indices])
			row_index += 1
			if row_index < adjusted_center				 
				number_of_indices += 1
			elsif row_index == adjusted_center
				number_of_indices += 0
			else
				number_of_indices -= 1
			end
		end
		l_indices
	end

	def right_indices
		r_indices = []
		right_rows = @number_of_rows - 1
		adjusted_center = right_rows / 2.0 + 1
		row_index = 1
		number_of_indices = 1
		while row_index < right_rows && number_of_indices > 0
			r_indices.push()
	end

	def top_indices
		
	end

	def bottom_indices
		
	end

	def smallest_axis_length
		[@number_of_rows, @number_of_columns].min
	end
end

def get_matrix_data(number_of_rows)
	matrix_data = []
	number_of_rows.times { matrix_data << get_line }
	matrix_data
end

def get_line
	gets.strip.split(" ").map(&:to_i)
end

params = MatrixParams.new(get_line)
my_matrix = MyMatrix.new(params.rows, params.columns, get_matrix_data)
my_matrix.rotate(params.rotations)