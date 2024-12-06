use std::io;
use std::collections::{HashMap, HashSet};

fn main() {
    let mut lines = io::stdin().lines().map(|l| l.unwrap()).into_iter();

    let mut orders: HashMap<u32, HashSet<u32>> = HashMap::new();
    let mut updates: Vec<Vec<u32>> = Vec::new();

    while let Some(line) = lines.next() {
        if line == "" {
            break
        }
        let mut values = line.split("|").map(|x| x.parse::<u32>().unwrap());
        if let (Some(x), Some(y)) = (values.next(), values.next()) {
            let e = orders.entry(x).or_insert(HashSet::new());
            e.insert(y);
        }
    }

    for line in lines {
        updates.push(line.split(",").map(|x| x.parse::<u32>().unwrap()).collect());
    }

    let mut sum = 0;

    'main: for update in updates {
        let mut visited = 0;
        let middle = update[update.len()/2];

        for num in update {
            if let Some(e) = orders.get(&num) {
                if e.contains(&visited) {
                    continue 'main;
                }
            }

            visited = num;
        }

        sum += middle;
    }

    println!("{sum}");
}
