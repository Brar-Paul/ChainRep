import React from 'react';
import { DAppProvider, ChainId, Kovan } from '@usedapp/core'
import { Header } from "./components/Header"
import { Container } from "@material-ui/core"
import { Main } from "./components/Main"
import { getDefaultProvider } from 'ethers'
import { Footer } from "./components/Footer"

function App() {
    return (
        <DAppProvider config={{
            readOnlyChainId: Kovan.chainId,
            readOnlyUrls: { [Kovan.chainId]: getDefaultProvider('kovan'), },
            networks: [Kovan],
            notifications: {
                expirationPeriod: 1000,
                checkInterval: 1000
            }
        }}>
            <Header />
            <Container maxWidth="md">
                <Main />
            </Container>
            <Footer />
        </DAppProvider>
    );
}

export default App;
