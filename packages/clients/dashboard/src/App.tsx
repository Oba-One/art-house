import Views from "./views";
import { Header } from "./components/Layout/Header";
import { Navigation } from "./components/Layout/Navigation";

import { WavesProvider } from "./hooks/providers/waves";

function App() {
  return (
    <WavesProvider>
      <Header />
      <Navigation />
      <Views />
    </WavesProvider>
  );
}

export default App;
