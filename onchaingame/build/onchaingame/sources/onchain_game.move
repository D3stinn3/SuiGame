// Declare the module onchaingame

module onchaingame::onchain_game {

    use std::option::{Self, Option};

    use sui::transfer;
    use sui::url::{Self, Url};
    use sui::object::{Self, UID};
    use std::string::{Self, String};
    use sui::tx_context::{Self, TxContext};

    // Module Structs

    // GameAdmin Capabilities or Cap
    struct GameAdminCap has key {
        id: UID
    }

    // Hero Struct
    struct Hero has key {
        id: UID,
        name: String,
        level: u64,
        hitpoints: u64,
        xp: u64,
        url: Url,
        sword: Option<Sword>,
    }

    // Sword Struct
    struct Sword has key, store {
        id: UID
    }


    // Game Admin Cap Initialization
    fun init(ctx: &mut TxContext) {
        transfer::transfer(
            GameAdminCap {
                id: object::new(ctx)
            },
            tx_context::sender(ctx)
        )
    }

    // Create a new hero. The game admin will create the hero and assign it an ID.
    public fun create_hero(
        _: &GameAdminCap,
        player: address,
        name: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
        ) {
            let hero = Hero {
                id: object::new(ctx),
                name: string::utf8(name),
                level: 1,
                hitpoints: 100,
                xp: 0,
                url: url::new_unsafe_from_bytes(url),
                sword: option::none()
            };

            transfer::transfer(hero, player);

        }
    
}
