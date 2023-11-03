// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Strings} from "openzeppelin-contracts/utils/Strings.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {IERC721Receiver} from "openzeppelin-contracts/token/ERC721/IERC721Receiver.sol";
import {SQLHelpers} from "tableland-contracts/utils/SQLHelpers.sol";
import {TablelandDeployments} from "tableland-contracts/utils/TablelandDeployments.sol";
import {TablelandController} from "@tableland/evm/contracts/TablelandController.sol";
import {TablelandPolicy} from "@tableland/evm/contracts/TablelandPolicy.sol";
import {Policies} from "@tableland/evm/contracts/policies/Policies.sol";

contract ArtTable is TablelandController, Ownable {
    // Store relevant table info
    uint256 private tableId; // Unique table ID
    string private constant _TABLE_PREFIX = "access_control"; // Custom table prefix
    address private _memberRegistry;

    // Constructor that creates a simple table with a an `id` and `val` column
    constructor(address memberRegistry) {
        // Create a table
        tableId = TablelandDeployments.get().create(
            address(this),
            SQLHelpers.toCreateFromSchema(
                "id integer primary key,"
                "account text,"
                "name text,"
                "artist int,"
                "bio text,"
                "social text,"
                "created_at integer",
                _TABLE_PREFIX
            )
        );

        _memberRegistry = memberRegistry;
    }

    function getPolicy(
        address caller,
        uint256
    ) public payable override returns (TablelandPolicy memory) {
        // Return allow-all policy if the caller is the owner
        if (caller == owner()) {
            return
                TablelandPolicy({
                    allowInsert: true,
                    allowUpdate: true,
                    allowDelete: true,
                    whereClause: "",
                    withCheck: "",
                    updatableColumns: new string[](0)
                });
        }

        if (caller == _memberRegistry) {
            return
                TablelandPolicy({
                    allowInsert: true,
                    allowUpdate: false,
                    allowDelete: true,
                    whereClause: "",
                    withCheck: "",
                    updatableColumns: new string[](0)
                });
        }

        // For all others, we'll let anyone insert but have controls on the update
        // First, establish WHERE clauses (i.e., where the address is the caller)
        string[] memory whereClause = new string[](1);
        whereClause[0] = string.concat(
            "account=",
            SQLHelpers.quote(Strings.toHexString(caller))
        );

        // Restrict updates to a single `val` column
        string[] memory updatableColumns = new string[](4);
        updatableColumns[0] = "name";
        updatableColumns[1] = "artist";
        updatableColumns[2] = "bio";
        updatableColumns[3] = "social";

        // Now, return the policy that gates by the WHERE clause & updatable columns
        // Note: insert calls won't need to check these additional parameters; they're just for the updates
        return
            TablelandPolicy({
                allowInsert: true,
                allowUpdate: true,
                allowDelete: false,
                whereClause: Policies.joinClauses(whereClause),
                withCheck: "",
                updatableColumns: updatableColumns
            });
    }

    function insert(
        account address, name memory string, artist uint256, bio memory string, social memory string
    ) external {
        TablelandDeployments.get().mutate(
            address(this), // Table owner, i.e., this contract
            tableId,
            SQLHelpers.toInsert(
                _TABLE_PREFIX,
                tableId,
                "account,name,artist,bio,social,created_at",
                string.concat(
                    SQLHelpers.quote(Strings.toHexString(account)), // Insert the caller's address
                    ",",
                    SQLHelpers.quote(name), // Wrap strings in single quotes with the `quote` method
                    ",",
                    SQLHelpers.quote(artist), // Wrap strings in single quotes with the `quote` method
                    ",",
                    SQLHelpers.quote(bio), // Wrap strings in single quotes with the `quote` method
                    ",",
                    SQLHelpers.quote(social) // Wrap strings in single quotes with the `quote` method
                    ",",
                    SQLHelpers.quote(block.timestamp) // Insert the current timestamp
                )
            )
        );
    }

    // Update only the row that the caller inserted
    function updateName(string memory name) external {
        // Set the values to update
        string memory setters = string.concat("name=", SQLHelpers.quote(name));
        // Specify filters for which row to update
        string memory filters = string.concat("account=", SQLHelpers.quote(Strings.toHexString(msg.sender)));
        // Mutate a row at `address` with a new `val`—gating for the correct row is handled by the controller contract
        TablelandDeployments.get().mutate(
            address(this),
            tableId,
            SQLHelpers.toUpdate(_TABLE_PREFIX, tableId, setters, filters)
        );
    }

    // Update only the row that the caller inserted
    function updateArtist(int artist) external {
        // Set the values to update
        string memory setters = string.concat("artist=", SQLHelpers.quote(artist));
        // Specify filters for which row to update
        string memory filters = string.concat("account=", SQLHelpers.quote(Strings.toHexString(msg.sender)));
        // Mutate a row at `address` with a new `val`—gating for the correct row is handled by the controller contract
        TablelandDeployments.get().mutate(
            address(this),
            tableId,
            SQLHelpers.toUpdate(_TABLE_PREFIX, tableId, setters, filters)
        );
    }

    // Update only the row that the caller inserted
    function updateBio(string memory bio) external {
        // Set the values to update
        string memory setters = string.concat("bio=", SQLHelpers.quote(bio));
        // Specify filters for which row to update
        string memory filters = string.concat("account=", SQLHelpers.quote(Strings.toHexString(msg.sender)));
        // Mutate a row at `address` with a new `val`—gating for the correct row is handled by the controller contract
        TablelandDeployments.get().mutate(
            address(this),
            tableId,
            SQLHelpers.toUpdate(_TABLE_PREFIX, tableId, setters, filters)
        );
    }

    // Update only the row that the caller inserted
    function updateSocial(string memory social) external {
        // Set the values to update
        string memory setters = string.concat("social=", SQLHelpers.quote(social));
        // Specify filters for which row to update
        string memory filters = string.concat("account=", SQLHelpers.quote(Strings.toHexString(msg.sender)));
        // Mutate a row at `address` with a new `val`—gating for the correct row is handled by the controller contract
        TablelandDeployments.get().mutate(
            address(this),
            tableId,
            SQLHelpers.toUpdate(_TABLE_PREFIX, tableId, setters, filters)
        );
    }

    // Delete a row via the member registry
    function deleteRow(address account) external {
        TablelandDeployments.get().mutate(
            address(this),
            tableId,
            SQLHelpers.toDelete(_TABLE_PREFIX, tableId, string.concat("account=", SQLHelpers.quote(Strings.toHexString(account))))
        );
    }

    // Needed for the contract to own a table
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
      return IERC721Receiver.onERC721Received.selector;
    }
}