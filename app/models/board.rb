class Board < ApplicationRecord
  validates :name, :email, :width, :height, :mines, presence: true
  validate :valid_mine_count

  after_create :generate_minesweeper_board

  def generate_minesweeper_board
    board = Array.new(height) { Array.new(width, 0) }
    mines_placed = 0

    while mines_placed < mines
      row = rand(height)
      col = rand(width)

      next if board[row][col] == 'M'

      board[row][col] = 'M'
      mines_placed += 1

      (-1..1).each do |i|
        (-1..1).each do |j|
          next if i == 0 && j == 0
          new_row, new_col = row + i, col + j
          if valid_position?(new_row, new_col) && board[new_row][new_col] != 'M'
            board[new_row][new_col] += 1
          end
        end
      end
    end

    self.board_data = board
    save
  end

  private

  def valid_mine_count
    if mines >= width * height
      errors.add(:mines, "cannot be more than or equal to the number of cells")
    end
  end

  def valid_position?(row, col)
    row >= 0 && row < height && col >= 0 && col < width
  end
end
