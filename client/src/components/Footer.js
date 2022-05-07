import React from 'react'
import { makeStyles } from "@material-ui/core"

const useStyles = makeStyles((theme) => ({
    container: {
        padding: theme.spacing(4),
        display: "flex",
        justifyContent: 'center',
        alignItems: 'center',
        gap: theme.spacing(1),
        marginTop: 4
    },
    a: {
        color: 'white'
    }
}))

export const Footer = () => {
    const classes = useStyles()
    return (
        <div className={classes.container}>
            <a href='https://github.com/Brar-Paul/DEFI-Project' className={classes.a}>Click Here For Git Hub Repo </a>
        </div>
    )
}
