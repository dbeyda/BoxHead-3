local c = {}

-- Categories up to 16
c.PLAYER_CATEGORY = 1
c.BULLET_CATEGORY = 2
c.WALL_CATEGORY   = 3
c.ZOMBIE_CATEGORY = 4

-- Bullet (projectile)
c.REGULAR_BULLET_SPEED = 1500
c.REGULAR_BULLET_DAMAGE = 10
c.REGULAR_BULLET_SIZE = {25, 25}
c.REGULAR_BULLET_COLOR = {255, 255, 255, 255}

-- Zombie
c.ZOMBIE_SIZE = {40, 40}
c.ZOMBIE_COLOR = {134, 0, 0, 255} 
c.ZOMBIE_SPEED = 100
c.ZOMBIE_DAMAGE = 5
c.ZOMBIE_HEALTH = 20
c.ZOMBIE_INTERVAL = 1
c.INITIAL_ZOMBIES = 100

-- Player
c.PLAYER_HEALTH = 100
c.PLAYER_SIZE = {40, 40}
c.PLAYER_SPEED = 300
c.PLAYER_INITIAL_POS = {400, 200}
c.PLAYER_SHOOTING_INTERVAL = 0.1
c.PLAYER_COLOR = {9, 184, 171, 255}

-- Directions
c.DIRECTION = {}
c.DIRECTION.N = "north"
c.DIRECTION.E = "east"
c.DIRECTION.S = "south"
c.DIRECTION.W = "west"
c.DIRECTION.NE = "northeast"
c.DIRECTION.SE = "southeast"
c.DIRECTION.NW = "northwest"
c.DIRECTION.SW = "southwest"

-- Key bindings
c.KEYS = {}
c.KEYS.SHOOT = "space"
c.KEYS.WALK_NORTH = "up"
c.KEYS.WALK_SOUTH = "down"
c.KEYS.WALK_EAST = "right"
c.KEYS.WALK_WEST = "left"


return c
