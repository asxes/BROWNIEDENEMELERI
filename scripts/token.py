#!/usr/bin/python3

from brownie import RockPaperScissors, accounts


def main():
    return RockPaperScissors.deploy("Test Token", "TST", 18, 1e21, {'from': accounts[0]})
