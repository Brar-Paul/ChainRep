from brownie import ChainRep, accounts, network, config


def get_account(index=None, id=None):
    if index:
        return accounts[index]
    if network.show_active() == "development":
        return accounts[0]
    if id:
        return accounts.load(id)
    return accounts.add(config["wallets"]["from_key"])


def deploy_chain_rep():
    account = get_account()
    chain_rep = ChainRep.deploy({"from": account})
    print(f"ChainRep deployed to {chain_rep.address}")


def main():
    deploy_chain_rep()
