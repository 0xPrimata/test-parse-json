// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import { Vm } from "forge-std/Vm.sol";
import { stdJson } from "forge-std/StdJson.sol";

contract ConfigScript is Script {
    using stdJson for string;
    struct ConfigData {
        uint256 minDelay;
        address[] labsSigners;
        address[] foundationSigners;
        address admin;
        uint256 labsThreshold;
        uint256 foundationThreshold;
    }
    struct ConfigData2 {
        address[] labsSigners;
        address[] foundationSigners;
        address admin;
        uint256 minDelay;
        uint256 labsThreshold;
        uint256 foundationThreshold;
    }
    ConfigData public config;
    ConfigData2 public config2;
    address public ZERO = address(0);

    function run() public {
        vm.startBroadcast();

        _loadConfig();
        _loadConfig2();

        vm.stopBroadcast();
    }

    function _loadConfig() internal {
        string memory path = string.concat(vm.projectRoot(), "/script/config.json");
        string memory json = vm.readFile(path);
        bytes memory rawConfigData = json.parseRaw(string(abi.encodePacked(".")));
        config = abi.decode(rawConfigData, (ConfigData));
        if (config.labsSigners[0] == ZERO) {
            console.log("labsSigner", config.labsSigners[0]);
            config.labsSigners[0] = vm.addr(1);
        }
        if (config.foundationSigners[0] == ZERO) {
            console.log("foundationSigner", config.foundationSigners[0]);
            config.foundationSigners[0] = vm.addr(1);
        }
    }

    function _loadConfig2() internal {
        string memory path = string.concat(vm.projectRoot(), "/script/config2.json");
        string memory json = vm.readFile(path);
        bytes memory rawConfigData = json.parseRaw(string(abi.encodePacked(".")));
        config = abi.decode(rawConfigData, (ConfigData));
        if (config.labsSigners[0] == ZERO) {
            console.log("labsSigner", config.labsSigners[0]);
            config.labsSigners[0] = vm.addr(1);
        }
        if (config.foundationSigners[0] == ZERO) {
            console.log("foundationSigner", config.foundationSigners[0]);
            config.foundationSigners[0] = vm.addr(1);
        }
    }
}
