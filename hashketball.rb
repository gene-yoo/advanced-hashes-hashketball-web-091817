require 'pry'

def game_hash
  {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1},
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7},
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15},
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5},
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1}
      }
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2},
        "Bismak Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10},
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5},
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0},
        "Brendan Haywood" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12}
      }
    }
  }
end

def num_points_scored(player_name)
  game_hash.each do |location, team_data|
    #binding.pry
    team_data[:players].each do |player, statistics|
      #binding.pry
      return statistics[:points] if (player == player_name)
    end
  end
end

def shoe_size(player_name)
  game_hash.each do |location, team_data|
    team_data[:players].each do |player, stats|
      return stats[:shoe] if (player == player_name)
    end
  end
end

def team_colors(team)
  game_hash.each do |location, team_data|
    if team_data[:team_name] == team
      return team_data[:colors]
    end
  end
end

def team_names
  game_hash.collect do |location, team_data|
    team_data[:team_name]
  end
end

def player_numbers(team)
  number = []
  game_hash.each do |location, team_data|
    if team_data[:team_name] == team
      team_data[:players].each do |player, stats|
        number << stats[:number]
      end
    end
  end
  number
end

def player_stats(name)
  game_hash.each do |location, team_data|
    team_data[:players].each do |player, stats|
      if player == name
        return stats
      end
    end
  end
end

def big_shoe_rebounds
  player_names = game_hash.collect do |location, team_data|
    team_data[:players].keys
  end.flatten

  player = player_names[0]
  max_shoe_size = shoe_size(player)

  player_names.each do |name|
    if shoe_size(name) > max_shoe_size
      max_shoe_size = shoe_size(name)
      player = name
    end
  end

  player_stats(player)[:rebounds]
end

# ----- bonus questions -----
def most_points_scored
  player_names = game_hash.collect do |location, team_data|
    team_data[:players].keys
  end.flatten

  player = player_names[0]
  max_points = num_points_scored(player)

  player_names.each do |name|
    if num_points_scored(name) > max_points
      max_points = num_points_scored(name)
      player = name
    end
  end

  player
end

def winning_team
  away_points = 0
  home_points = 0
  winner = ""

  game_hash[:away][:players].keys.each do |name|
    away_points += num_points_scored(name)
  end

  game_hash[:home][:players].keys.each do |name|
    home_points += num_points_scored(name)
  end

  if away_points == home_points
    winner = "Tie!"
  elsif away_points > home_points
    winner = game_hash[:away][:team_name]
  else
    winner = game_hash[:home][:team_name]
  end

  winner
end

def player_with_longest_name
  player_names = game_hash.collect do |location, team_data|
    team_data[:players].keys
  end.flatten

  player = player_names[0]
  max_length = player.length

  player_names.each do |name|
    if name.length > max_length
      max_length = name.length
      player = name
    end
  end

  player
end

# ----- super bonus -----
def num_steals(player_name)
  game_hash.each do |location, team_data|
    team_data[:players].each do |player, statistics|
      return statistics[:steals] if (player == player_name)
    end
  end
end

def long_name_steals_a_ton?
  player_with_long_name = player_with_longest_name

  other_players = game_hash.collect do |location, team_data|
    team_data[:players].keys
  end.flatten

  other_players.delete(player_with_long_name)

  other_players.all? do |name|
    num_steals(player_with_long_name) > num_steals(name)
  end
end
