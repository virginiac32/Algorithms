## Problem
This is a two part problem:
1. First, write a series of instructions on how to build out an LRU Cache (pretend
the person you're writing to has no idea how to build one. Don't forget to address
the reasoning behind using particular data structures).
2. Implement an LRU Cache from scratch with no outside references. **Don't look
at the code or instructions from your homework!**

## Solution

### Part 1
Write first part here:
1. An LRU cache has a set number of spaces, and the most recently used
or accessed items are appended to the end. If the cache is filled, the least recently used item will be pushed out of the cache. An LRU can be implemented
with a linked list and hashmap.
2. The linked list will be the actual cache - new items are appended to the end as nodes. If an item is already in the cache, it'll be moved out of its current spot and moved to the end. If the cache is full, each time something new is added,
the first node will be removed.
3. The hashmap will be used to access nodes in O(1) time. To do so, each
time a node is added to the linked list, it will also be added to the hashmap
as a key value pair (with the key being the key of the cache and the value
being the actual node). So searching for keys will be in O(1) time

### Part 2
```ruby
class LRUCache
  
end
```
