import { Toaster } from "react-hot-toast";
import { Route, Routes } from "react-router-dom";

import { ArtHouseProvider } from "./hooks/providers/artHouse";

import { Header } from "./components/Layout/Header";
import { Navigation } from "./components/Layout/Navigation";

import Views from "./views";
import { AuthView } from "./views/auth";

function App() {
  return (
    <ArtHouseProvider>
      <Routes>
        <Route
          path="*"
          element={
            <>
              <Header />
              <Navigation />
              <Views />
              <Toaster />
            </>
          }
        />
        <Route path="/auth/*" element={<AuthView />} />
      </Routes>
      <Toaster />
    </ArtHouseProvider>
  );
}

export default App;
