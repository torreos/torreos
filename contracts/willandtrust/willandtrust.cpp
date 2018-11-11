#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

using namespace eosio;

class [[eosio::contract]] willandtrust : public eosio::contract {
public:
    using contract::contract;
    willandtrust(name receiver, name code, datastream<const char *> ds) : contract(receiver, code, ds) {}
    
    [[eosio::action]]
    void upsert(name user, std::string sigA, std::string sigB, std::string docHash) {
        require_auth( user );

        // 256 bit hash will be encoded to 44 characters in Base64 representation
        eosio_assert(sigA.size() == 44, "sigA not valid");
        eosio_assert(sigB.size() == 44, "sigB not valid");
        eosio_assert(docHash.size() == 44, "docHash not valid");
        
        willandtrust_tbl_type wtstamps(_code, _code.value);
        auto iterator = wtstamps.find(user.value);
        if (iterator == wtstamps.end()) {
            //The user isn't in the table
            wtstamps.emplace(user, [&](auto &row) {
                row.key = user;
                row.sigA = sigA;
                row.sigB = sigB;
                row.docHash = docHash;
            });
            }
        else
            {
                //The user is in the table
            wtstamps.modify(iterator, user, [&](auto &row) {
                row.key = user;
                row.sigA = sigA;
                row.sigB = sigB;
                row.docHash = docHash;
            });
            }
        
    }
    
    [[eosio::action]]
    void erase(name user) {
        require_auth(user);
        willandtrust_tbl_type wtstamps(_code, _code.value);

        auto iterator = wtstamps.find(user.value);
        eosio_assert(iterator != wtstamps.end(), "Record does not exist");
        wtstamps.erase(iterator);
    }
    
private:
    // will and trust stamp struct
    struct [[eosio::table]] wtstamp {
        name key;
        std::string sigA ;
        std::string sigB;
        std::string docHash;
        
        uint64_t primary_key() const {return key.value;}
    };
    
    typedef eosio::multi_index<"wtstamps"_n, wtstamp> willandtrust_tbl_type;
};

EOSIO_DISPATCH( willandtrust, (upsert)(erase))