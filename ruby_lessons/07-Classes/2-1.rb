require 'colorize'

class Weapon
  attr_reader :name, :damage, :crit

  def initialize(name, damage, crit = 0)
    @name = name
    @damage = damage
    @crit = crit
  end

  def to_s
    "#{@name} (#{@damage} dmg, +#{@crit} crit)"
  end
end

class Armor
  attr_reader :name, :defense

  def initialize(name, defense)
    @name = name
    @defense = defense
  end

  def to_s
    "#{@name} (defense #{@defense})"
  end
end

class Character
  attr_accessor :health, :attack, :defense, :name

  def initialize(health, attack, defense, name)
    @health = health
    @attack = attack
    @defense = defense
    @name = name
  end

  def alive?
    @health > 0
  end
end

class Player < Character
  attr_accessor :weapon, :armor, :elixirs

  def initialize(health, name)
    super(health, 0, 0, name)
    @weapon = nil
    @armor = nil
    @elixirs = 0
  end

  def effective_attack
    #if the player has weapon, use the weapon damage
    if @weapon
      @weapon.damage
    else
      @attack
    end
  end

  def effective_defense
    #if the player has armor, use armor defense
    if @armor
      @armor.defense
    else
      @defense
    end
  end
end

class Enemy < Character
  #enemies have crit chance and counter chance attributes
  attr_accessor :crit_chance, :counter_chance

  def initialize(health, attack, defense, name, crit_chance = 0.1, counter_chance = 0.15)
    super(health, attack, defense, name)
    @crit_chance = crit_chance
    @counter_chance = counter_chance
  end
end

#status (learn this from AI to create color based on user's HP)
def colorize_health(hp, max_hp=100)
  percentage = (hp.to_f / max_hp.to_f) * 100
  if percentage > 60
    hp.to_s.colorize(:green)
  elsif percentage > 30
    hp.to_s.colorize(:yellow)
  else
    hp.to_s.colorize(:red)
  end
end

def pause_line
  puts "----------------------------------------"
end

def prompt(msg)
  print msg
  gets.chomp
end

def valid_integer_input(prompt_msg, range = nil)
  loop do
    input = prompt(prompt_msg)
    if input =~ /^\d+$/
      n = input.to_i
      return n if range.nil? || range.include?(n)
    end
    puts "Invalid input. Try again.".colorize(:light_red)
  end
end


#game starts here
puts "Welcome to Terminal Monster Brawl!".colorize(:cyan)
player_name = prompt("Enter player name: ").strip
player_name = "Hero" if player_name.empty?

player = Player.new(100, player_name)

#weapon section
weapons = [
  #weapon values (name, dmg, crit bonus)
  Weapon.new("Dagger", 13, 0.15),
  Weapon.new("Sword", 20, 0.05),
]

#armor section
armors = [
  #armor values (name, defense)
  Armor.new("Leather Shirt", 5),
]

#select weapon
puts "\nWeapons:".colorize(:light_blue)
weapons.each_with_index do |w, i|
  puts "#{i} - #{w.to_s}"
end
weapon_choice = valid_integer_input("Select weapon index: ", 0...weapons.length)
player.weapon = weapons[weapon_choice]
puts "#{player.weapon.name} equipped.".colorize(:light_green)

#select armor
puts "\nArmors:".colorize(:light_blue)
armors.each_with_index do |a, i|
  puts "#{i} - #{a.to_s}"
end
armor_choice = valid_integer_input("Select armor index: ", 0...armors.length)
player.armor = armors[armor_choice]
puts "#{player.armor.name} equipped.".colorize(:light_green)

#elixir
player.elixirs = valid_integer_input("\nHow many elixirs do you carry? (0-5): ", 0..5)
puts "#{player.elixirs} elixir(s) in inventory.".colorize(:light_magenta)

#enemy section
enemies = []
#enemy inherit from character with values (health, attack, and defense)
#so enemy values are (health, attack, defense, name, crit, counter)
enemies << Enemy.new(100, 20, 10, "Dragon", 0.12, 0.10)
enemies << Enemy.new(50, 10, 3, "Orc", 0.08, 0.12)
enemies << Enemy.new(20, 8, 0, "Wolf", 0.06, 0.05)

puts "\n******* Battle Start! *******".colorize(:light_cyan)
round = 0

#combar loops
while player.alive? && enemies.any? { |e| e.alive? }
  round += 1
  puts "\n--------- Round #{round} ---------".colorize(:light_blue)

  #showing enemies
  alive_enemies = enemies.each_with_index.select { |e, idx| e.alive? }.map { |pair| pair[0] }
  #show with index relative to list of alive enemies
  puts "Enemies:"
  idx_map = {}
  alive_enemies.each_with_index do |en, i|
    idx_map[i] = en
    status = "#{en.name} (HP: #{en.health})"
    puts "#{i} - #{status.colorize(:red)}"
  end

  #select target
  target_index = nil
  loop do
    input = prompt("Select enemy to attack (index) or type 'q' to quit: ")
    if input.strip.downcase == 'q'
      puts "You chose to quit. Game over.".colorize(:yellow)
      exit
    end
    if input =~ /^\d+$/
      n = input.to_i
      if idx_map.key?(n)
        target_index = n
        break
      end
    end
    puts "Invalid selection. Try again.".colorize(:light_red)
  end

  target = idx_map[target_index]

  #choose enemy
  #calculate critical: base 0.05 + weapon crit
  base_crit = 0.05
  weapon_crit = player.weapon ? player.weapon.crit : 0
  crit_chance = base_crit + weapon_crit
  crit = rand < crit_chance

  #damage calculation
  raw_dmg = player.effective_attack
  dmg = raw_dmg - target.defense
  dmg = 1 if dmg < 1
  dmg = (dmg * 1.5).to_i if crit

  target.health -= dmg
  puts "\n#{player.name} attacked! #{target.name} took #{dmg} damage#{' (CRITICAL!)'.colorize(:yellow) if crit}"
  if !target.alive?
    puts "#{target.name} was slain!".colorize(:light_red)
  end

  #each alive enemy gets a turn to attack (unless they died)
  enemies.each do |enemy|
    next unless enemy.alive?

    #if the enemy is dead it shouldn't attack, break if the player died
    break unless player.alive?

    #enemy attempts to attack player (skip if this was the target and just died)
    if enemy == target && !enemy.alive?
      next
    end

    #enemy attack
    #enemy critical chance
    enemy_crit = rand < enemy.crit_chance
    raw_enemy_dmg = enemy.attack
    dmg_to_player = raw_enemy_dmg - player.effective_defense
    dmg_to_player = 1 if dmg_to_player < 1
    dmg_to_player = (dmg_to_player * 1.5).to_i if enemy_crit

    # chance for player to counter-attack before taking damage
    counter_chance = 0.15
    if rand < counter_chance
      #counter attack deals half of player's weapon damage (minimum 1)
      counter_dmg = [(player.effective_attack / 2).to_i, 1].max
      enemy.health -= counter_dmg
      puts "#{enemy.name} tried to attack, but #{player.name} counter attacked! #{enemy.name} took #{counter_dmg} damage."
      puts "#{enemy.name} was slain!".colorize(:light_red) if !enemy.alive?
      #if enemy died because of counter, they don't deal damage back
      next unless enemy.alive?
    end

    player.health -= dmg_to_player
    if enemy_crit
      puts "#{enemy.name} attacked! #{player.name} took #{dmg_to_player} damage (CRITICAL!).".colorize(:red)
    else
      puts "#{enemy.name} attacked! #{player.name} took #{dmg_to_player} damage."
    end

    #short delay look-alike: just a blank line for readability
  end

  #show player stats
  max_hp = 100
  print "\n#{player.name} health: "
  puts colorize_health(player.health, max_hp)

  #offer player using an elixir if alive
  if player.alive? && player.elixirs > 0
    use = prompt("Would you like to drink an elixir? [y/n]: ").strip.downcase
    if use == 'y' || use == 'yes'
      heal_amount = 30
      player.health += heal_amount
      player.elixirs -= 1
      puts "#{player.name} drank an elixir and restored #{heal_amount} HP.".colorize(:light_green)
      puts "#{player.name} health is now: #{colorize_health(player.health, max_hp)}"
      puts "#{player.elixirs} elixir(s) left.".colorize(:light_magenta)
    end
  end

  #remove dead enemies from list
  puts
  pause_line
end

#result
if player.alive?
  turns_text = round == 1 ? "turn" : "turns"
  puts "\nCongratulations, you slayed all enemies in #{round} #{turns_text}!".colorize(:light_green)
else
  puts "\nYou were slain... Game over.".colorize(:red)
end
