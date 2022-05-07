import React, { Form } from 'react'
import { useState } from 'react'
import { useEthers, useContractFunction } from '@usedapp/core'
import { Box, makeStyles, Button, Input, CircularProgress, Snackbar, FormControl, TextField, Grid, FormControlLabel, FormLabel, RadioGroup, Radio } from "@material-ui/core"

const useStyles = makeStyles((theme) => ({
    box: {
        backgroundColor: "white",
        borderRadius: "25px",
        alignItems: 'center',
        justify: 'center',
        direction: 'column'
    },
    header: {
        color: "white"
    },
    grid: {
        alignItems: 'center',
        justify: 'center',
        direction: 'column'
    }
}))

export const ReviewForm = ({ contract }) => {
    const classes = useStyles()
    const [rating, setRating] = useState(0)
    const [description, setDescription] = useState('')
    const [category, setCategory] = useState('')
    const [reviewed, setReviewed] = useState('')

    const handleSubmit = async () => {
        if (!rating || !description || !category || !reviewed) return
        // useContractFunction
    }

    return (
        <Box>
            <h1 className={classes.header}>Submit Review</h1>
            <Box className={classes.box}>
                <form>
                    <Grid container alignItems="center" justify="center" direction="column" padding='4'>
                        <Grid item>
                            <TextField
                                id="reviewed-input"
                                name="reviewed"
                                label="ETH Address"
                                type="text"
                                onChange={(e) => setReviewed(e.target.value)}
                            />
                        </Grid>
                        <Grid item>
                            <TextField
                                id="description-input"
                                name="description"
                                label="Description"
                                type="text"
                                onChange={(e) => setDescription(e.target.value)}
                            />
                        </Grid>
                        <Grid item>
                            <TextField
                                id="category-input"
                                name="category"
                                label="Category"
                                type="text"
                                onChange={(e) => setCategory(e.target.value)}
                            />
                        </Grid>
                        <Grid item>
                            <FormControl>
                                <FormLabel>Rating</FormLabel>
                                <RadioGroup
                                    name="rating"
                                    onChange={(e) => setRating(e.target.value)}
                                    row
                                >
                                    <FormControlLabel
                                        key="1"
                                        value="1"
                                        control={<Radio size="small" />}
                                        label="1"
                                    />
                                    <FormControlLabel
                                        key="2"
                                        value="2"
                                        control={<Radio size="small" />}
                                        label="2"
                                    />
                                    <FormControlLabel
                                        key="3"
                                        value="3"
                                        control={<Radio size="small" />}
                                        label="3"
                                    />
                                    <FormControlLabel
                                        key="4"
                                        value="4"
                                        control={<Radio size="small" />}
                                        label="4"
                                    />
                                    <FormControlLabel
                                        key="5"
                                        value="5"
                                        control={<Radio size="small" />}
                                        label="5"
                                    />
                                </RadioGroup>
                            </FormControl>
                        </Grid>
                    </Grid>
                </form>
            </Box>
        </Box>
    )
}


