package main

import (
	"bufio"
	"os"
)

type point struct {
	x, y int
}

func (s *point) add(d point) {
	s.x += d.x
	s.y += d.y
}

func (s *point) peek(d point) point {
	return point{
		x: s.x + d.x,
		y: s.y + d.y,
	}
}

func (s *point) turn() {
	s.x, s.y = -s.y, s.x
}

type guardType struct {
	pos point
	dir point
}

func (g *guardType) move() {
	g.pos.add(g.dir)
}

func (g *guardType) turn() {
	g.dir.turn()
}

func (g *guardType) peek() point {
	return g.pos.peek(g.dir)
}

func (g *guardType) inbounds() bool {
	return g.pos.x >= 0 && g.pos.x < width && g.pos.y >= 0 && g.pos.y < height
}

func (g guardType) looped() bool {
	visited := make(map[guardType]bool)
	for g.inbounds() {
		_, ok := blocks[g.peek()]
		if ok {
			g.turn()
		}
		_, ok = blocks[g.peek()]
		if ok {
			g.turn()
		}
		if visited[g] {
			return true
		}
		visited[g] = true
		g.move()
	}
	return false
}

type block struct{}

var (
	width     int
	height    int
	blocks    map[point]block
	guard     guardType
	startpos  guardType
	path      []guardType
	obstacles map[point]block
)

func main() {
	stdio := bufio.NewReader(os.Stdin)
	blocks = make(map[point]block)
	path := make([]guardType, 0, 1024)
	obstacles := make(map[point]block)
	guard.dir.y = -1

	for {
		line, err := stdio.ReadString('\n')
		if err != nil {
			break
		}

		for i := 0; i < len(line); i++ {
			p := point{x: i, y: height}
			switch line[i] {
			case '#':
				blocks[p] = block{}
				break
			case '^':
				guard.pos = p
				break
			}
		}
		width = len(line) - 1
		height++
	}
	startpos = guard

	for guard.inbounds() {
		_, ok := blocks[guard.peek()]
		if ok {
			guard.turn()
		}
		_, ok = blocks[guard.peek()]
		if ok {
			guard.turn()
		}
		path = append(path, guard)
		guard.move()
	}

	for _, start := range path {
		blocks[start.pos] = block{}
		if startpos.looped() {
			obstacles[start.pos] = block{}
		}
		delete(blocks, start.pos)
	}

	print(len(obstacles), "\n")
}
