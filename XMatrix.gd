# var rows
# var cols
# var data = []

# class_name Matrix


# func _init(numRows, numCols):
# 	self.rows = numRows
# 	self.cols = numCols
# 	for x in range(rows):
# 		self.data[x] = []
# 		for y in range(cols):
# 			self.data[x][y] = 0
	
# # Make a new copy with the same "properties"
# # func copy():
# # 	var m = Matrix.new(self.rows, self.cols)
# # 	for i in range(self.rows):
# # 		for j in range(self.cols):
# # 			m.data[i][j] = self.data[i][j]
# # 	return m
	
# static func fromArray(arr):
# 	var result: Matrix = Matrix.new(arr.len, arr[0].len)
# 	for i in range(arr.len):
# 		for j in range(arr[i].len):
# 			result.data[i][j] = arr[i][j]
# 	return result
	
# func toArray():
# 	var arr = []
# 	for i in range(self.rows):
# 		for j in range(self.cols):
# 			arr.append(self.data[i][j])
# 	return arr

# # subtract
# static func subtract(a: Matrix, b: Matrix):
# 	if a.rows != b.rows || a.cols != b.cols:
# 		print('Columns and Rows of A must match Columns and Rows of B.')
	
# 	var result = Matrix.new(a.rows, a.cols)	
# 	for i in range(result.rows):
# 		for j in range(result.cols):
# 			result.data[i][j] = a.data[i][j] - b.data[i][j]
# 	return result
		
# func randomizeIt():
# 	for x in range(rows):
# 		self.data[x] = []
# 		for y in range(cols):
# 			self.data[x][y] = rand_range(-1, 1)
			
# func add(n):
# 	if n is Matrix:
# 		if self.rows != n.rows || self.cols != n.cols:
# 			print('Columns and Rows of A must match Columns and Rows of B.')
# 			return
# 		for i in range(self.rows):
# 			for j in range(self.cols):
# 				self.data[i][j] += n.data[i][j]
# 	else:
# 		for i in range(self.rows):
# 			for j in range(self.cols):
# 				self.data[i][j] += n

# static func transpose(matrix):
# 	var result = Matrix.new(matrix.cols, matrix.rows)
# 	for i in range(matrix.rows):
# 		for j in range(matrix.cols):
# 			result.data[j][i] = matrix.data[i][j]
# 	return result

# static func multiply(a, b):
# 	if a.cols != b.rows:
# 		print('Columns of A must match rows of B.')
# 		return null
# 	var result = Matrix.new(a.rows, b.cols)
# 	for i in range(result.rows):
# 		for j in range(result.cols):
# 			var sum = 0
# 			for k in range(a.cols):
# 				sum += a.data[i][k] * b.data[k][j]
# 			result.data[i][j] = sum
# 	return result

# func mult(n):
# 	if n is Matrix:
# 		if self.rows != n.rows || self.cols != n.cols:
# 			print('Columns and Rows of A must match Columns and Rows of B.')
# 			return
# 		for i in range(self.rows):
# 			for j in range(self.cols):
# 				self.data[i][j] *= n.data[i][j]
# 	else:
# 		for i in range(self.rows):
# 			for j in range(self.cols):
# 				self.data[i][j] *= n
	
# func printIt():
# 	print(self.data)
