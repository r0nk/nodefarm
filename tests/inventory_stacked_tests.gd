extends TestSuite

var inventory: InventoryStacked
var inventory_2: InventoryStacked
var item: InventoryItem
var big_item: InventoryItem
var stackable_item: InventoryItem
var stackable_item_2: InventoryItem
var limited_stackable_item: InventoryItem
var limited_stackable_item_2: InventoryItem


func init_suite() -> void:
    tests = [
        "test_space",
        "test_big_item",
        "test_change_capacity",
        "test_unlimited_capacity",
        "test_invalid_capacity",
        "test_contents_changed_signal",
        "test_stack_split_join",
        "test_automerge",
        "test_max_stack_size",
        "test_transfer",
        "test_transfer_autosplit",
        "test_transfer_autosplitmerge",
        "test_serialize",
        "test_serialize_json"
    ]


func init_test() -> void:
    inventory = InventoryStacked.new()
    inventory.item_protoset = preload("res://tests/data/item_definitions_stack.tres")
    inventory.capacity = 10

    inventory_2 = InventoryStacked.new()
    inventory_2.item_protoset = preload("res://tests/data/item_definitions_stack.tres")
    inventory_2.capacity = 10

    item = InventoryItem.new()
    item.protoset = preload("res://tests/data/item_definitions_stack.tres")
    item.prototype_id = "minimal_item"

    big_item = InventoryItem.new()
    big_item.protoset = preload("res://tests/data/item_definitions_stack.tres")
    big_item.prototype_id = "big_item"

    stackable_item = InventoryItem.new()
    stackable_item.protoset = preload("res://tests/data/item_definitions_stack.tres")
    stackable_item.prototype_id = "stackable_item"

    stackable_item_2 = InventoryItem.new()
    stackable_item_2.protoset = preload("res://tests/data/item_definitions_stack.tres")
    stackable_item_2.prototype_id = "stackable_item"

    limited_stackable_item = InventoryItem.new()
    limited_stackable_item.protoset = preload("res://tests/data/item_definitions_stack.tres")
    limited_stackable_item.prototype_id = "limited_stackable_item"

    limited_stackable_item_2 = InventoryItem.new()
    limited_stackable_item_2.protoset = preload("res://tests/data/item_definitions_stack.tres")
    limited_stackable_item_2.prototype_id = "limited_stackable_item"


func cleanup_test() -> void:
    free_inventory(inventory)
    free_inventory(inventory_2)

    free_item(item)
    free_item(big_item)
    free_item(stackable_item)
    free_item(stackable_item_2)
    free_item(limited_stackable_item)
    free_item(limited_stackable_item_2)


func test_space() -> void:
    assert(inventory.capacity == 10.0)
    assert(inventory.get_free_space() == 10.0)
    assert(inventory.occupied_space == 0.0)
    assert(inventory.has_place_for(item))
    assert(inventory.add_item(item))
    assert(inventory.occupied_space == 1.0)
    assert(inventory.get_free_space() == 9.0)


func test_big_item() -> void:
    assert(!inventory.has_place_for(big_item))
    assert(!inventory.add_item(big_item))


func test_change_capacity() -> void:
    inventory.capacity = 0.5
    assert(!inventory.has_place_for(item))
    assert(!inventory.add_item(item))


func test_unlimited_capacity() -> void:
    inventory.capacity = 0
    assert(inventory.has_place_for(item))
    assert(inventory.add_item(item))
    assert(inventory.has_place_for(big_item))
    assert(inventory.add_item(big_item))


func test_invalid_capacity() -> void:
    inventory.capacity = 21
    assert(inventory.add_item(big_item))
    inventory.capacity = 19
    assert(inventory.capacity == 21)


func test_contents_changed_signal() -> void:
    # These checks cause some warnings:
    #
    # assert(inventory.add_item(item))
    # assert(inventory.occupied_space == 1.0)
    # item.queue_free()
    # await inventory.contents_changed
    # assert(inventory.occupied_space == 0.0)
    pass


func test_stack_split_join() -> void:
    assert(inventory.add_item(stackable_item))
    assert(inventory.split(stackable_item, 5) != null)
    assert(inventory.get_items().size() == 2)
    var item1 = inventory.get_items()[0]
    var item2 = inventory.get_items()[1]
    assert(item1.get_property(InventoryStacked.KEY_STACK_SIZE) == 5)
    assert(item2.get_property(InventoryStacked.KEY_STACK_SIZE) == 5)
    var joined = inventory.join(item1, item2)
    assert(joined)
    assert(item1.get_property(InventoryStacked.KEY_STACK_SIZE) == 10)
    assert(inventory.get_items().size() == 1)


func test_automerge() -> void:
    stackable_item.set_property(InventoryStacked.KEY_STACK_SIZE, 2)
    stackable_item_2.set_property(InventoryStacked.KEY_STACK_SIZE, 2)
    assert(inventory.add_item_automerge(stackable_item))
    assert(inventory.get_items().size() == 1)
    assert(is_instance_valid(stackable_item))
    assert(inventory.add_item_automerge(stackable_item_2))
    assert(inventory.get_items().size() == 1)


func test_max_stack_size() -> void:
    limited_stackable_item.set_property(InventoryStacked.KEY_STACK_SIZE, 3)
    assert(inventory.add_item(limited_stackable_item))
    assert(limited_stackable_item.get_property(InventoryStacked.KEY_STACK_SIZE) == 3)
    assert(inventory.add_item_automerge(limited_stackable_item_2))
    assert(limited_stackable_item.get_property(InventoryStacked.KEY_STACK_SIZE) == 5)
    assert(limited_stackable_item_2.get_property(InventoryStacked.KEY_STACK_SIZE) == 3)


func test_transfer() -> void:
    assert(inventory.add_item(limited_stackable_item))
    assert(inventory_2.add_item(limited_stackable_item_2))
    assert(inventory.transfer(limited_stackable_item, inventory_2))
    assert(!inventory.has_item(limited_stackable_item))
    assert(inventory_2.has_item(limited_stackable_item))
    assert(inventory_2.has_item(limited_stackable_item_2))


func test_transfer_autosplit() -> void:
    stackable_item.set_property(InventoryStacked.KEY_STACK_SIZE, 7)
    stackable_item_2.set_property(InventoryStacked.KEY_STACK_SIZE, 5)
    assert(inventory.add_item(stackable_item))
    assert(inventory_2.add_item(stackable_item_2))
    assert(inventory_2.transfer_autosplit(stackable_item_2, inventory))
    assert(stackable_item.get_property(InventoryStacked.KEY_STACK_SIZE) == 7)
    assert(stackable_item_2.get_property(InventoryStacked.KEY_STACK_SIZE) == 2)
    assert(inventory.get_items().size() == 2)
    assert(inventory.occupied_space == 10)
    assert(inventory_2.get_items().size() == 1)
    assert(inventory_2.occupied_space == 2)


func test_transfer_autosplitmerge() -> void:
    stackable_item.set_property(InventoryStacked.KEY_STACK_SIZE, 7)
    stackable_item_2.set_property(InventoryStacked.KEY_STACK_SIZE, 5)
    assert(inventory.add_item(stackable_item))
    assert(inventory_2.add_item(stackable_item_2))
    assert(inventory_2.transfer_autosplitmerge(stackable_item_2, inventory))
    assert(stackable_item.get_property(InventoryStacked.KEY_STACK_SIZE) == 10)
    assert(stackable_item_2.get_property(InventoryStacked.KEY_STACK_SIZE) == 2)
    assert(inventory.get_items().size() == 1)
    assert(inventory.occupied_space == 10)
    assert(inventory_2.get_items().size() == 1)


func test_serialize() -> void:
    assert(inventory.add_item(item))
    var inventory_data = inventory.serialize()
    var capacity = inventory.capacity
    var occupied_space = inventory.occupied_space
    inventory.reset()
    assert(inventory.get_items().is_empty())
    assert(inventory.capacity == 0)
    assert(inventory.occupied_space == 0)
    assert(inventory.deserialize(inventory_data))
    assert(inventory.get_items().size() == 1)
    assert(inventory.capacity == capacity)
    assert(inventory.occupied_space == occupied_space)
    

func test_serialize_json() -> void:
    assert(inventory.add_item(item))
    var inventory_data = inventory.serialize()
    var capacity = inventory.capacity
    var occupied_space = inventory.occupied_space

    # To and from JSON serialization
    var json_string: String = JSON.stringify(inventory_data)
    var test_json_conv: JSON = JSON.new()
    assert(test_json_conv.parse(json_string) == OK)
    inventory_data = test_json_conv.data

    inventory.reset()
    assert(inventory.get_items().is_empty())
    assert(inventory.capacity == 0)
    assert(inventory.occupied_space == 0)
    assert(inventory.deserialize(inventory_data))
    assert(inventory.get_items().size() == 1)
    assert(inventory.capacity == capacity)
    assert(inventory.occupied_space == occupied_space)

