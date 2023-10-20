import { createBrowserRouter, Route, RouterProvider } from "react-router-dom";
import { Toaster } from "react-hot-toast";

import { ArtHouseProvider } from "./hooks/providers/artHouse";

import { Header } from "./components/Layout/Header";
import { Navigation } from "./components/Layout/Navigation";

import Views from "./views";
import { AuthView } from "./views/auth";

const router = createBrowserRouter([
  {
    path: "*",
    element: (
      <>
        <Header />
        <Navigation />
        <Views />
      </>
    ),
    // loader: rootLoader,
  },
  {
    path: "/auth",
    element: <AuthView />,
    // loader: rootLoader,
  },
]);

function App() {
  return (
    <ArtHouseProvider>
      <Toaster />
      <RouterProvider router={router} />
    </ArtHouseProvider>
  );
}

export default App;
