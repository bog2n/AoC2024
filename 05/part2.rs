use std::io;
use std::collections::{HashMap, HashSet};

struct Printer {
    orders: HashMap<u32, HashSet<u32>>,
    updates: Vec<Vec<u32>>,
}

impl Printer {
    fn new() -> Self {
        Printer {
            orders: HashMap::new(),
            updates: Vec::new(),
        }
    }

    fn get_wrong_index(&self, update: &Vec<u32>) -> Option<usize> {
        let mut visited = 0;

        for (index, num) in update.into_iter().enumerate() {
            if let Some(e) = self.orders.get(&num) {
                if e.contains(&visited) {
                    return Some(index);
                }
            }

            visited = *num;
        }

        return None;
    }
}

fn main() {
    let mut lines = io::stdin().lines().map(|l| l.unwrap()).into_iter();

    let mut p = Printer::new();

    while let Some(line) = lines.next() {
        if line == "" {
            break
        }
        let mut values = line.split("|").map(|x| x.parse::<u32>().unwrap());
        if let (Some(x), Some(y)) = (values.next(), values.next()) {
            let e = p.orders.entry(x).or_insert(HashSet::new());
            e.insert(y);
        }
    }

    for line in lines {
        p.updates.push(line.split(",").map(|x| x.parse::<u32>().unwrap()).collect());
    }

    let mut sum = 0;

    for update in &p.updates {
        let mut new = update.clone();
        let mut ok = false;

        while let Some(i) = p.get_wrong_index(&new) {
            new.swap(i-1, i);
            ok = true;
        }

        if ok {
            sum += new[new.len()/2];
        }
    }

    println!("{sum}");
}
