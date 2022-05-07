import React from 'react'
import networkMapping from "../artifacts/deployments/map.json"
import { makeStyles } from "@material-ui/core"
import { constants, utils } from "ethers"
import { useEthers, ChainId } from "@usedapp/core"
import { ReviewForm } from './ReviewForm'
import { Contract } from '@ethersproject/contracts'

import ChainRep from "../artifacts/contracts/ChainRep.json"

const useStyles = makeStyles((theme) => ({
    title: {
        color: theme.palette.common.white,
        textAlign: "center",
        padding: theme.spacing(1)
    },
    container: {
        textAlign: 'center',
    }
}))

export const Main = () => {
    const classes = useStyles()
    const { chainId, error } = useEthers()
    const { abi } = ChainRep
    const chainRepInterface = new utils.Interface(abi)
    const chainRepAddress = chainId ? networkMapping[String(chainId)]["ChainRep"][0] : constants.AddressZero
    const chainRepContract = new Contract(chainRepAddress, chainRepInterface)



    return (<>
        <h1 className={classes.title}>ChainRep</h1>
        <h3 className={classes.title}>BlockChain user reviews</h3>
        <p className={classes.title}>Please connect to Kovan Testnet.</p>
        <div className={classes.container}>
            <a className={classes.title} href="https://faucets.chain.link/">Click here for Kovan ETH</a>
        </div>
        <ReviewForm contract={chainRepContract} />
    </>
    )
}

export default Main
