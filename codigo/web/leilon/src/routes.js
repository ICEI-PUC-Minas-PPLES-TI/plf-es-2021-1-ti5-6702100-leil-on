import { BrowserRouter, Route, Switch } from "react-router-dom";

import Login from "./components/Login";
import Register from "./components/Register";
import Dashboard from "./components/Dashboard";
import CreateAuction from "./components/CreateAuction";
import Profile from "./components/Profile";
import SearchAuction from "./components/SearchAuction";

export default function Routes() {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/" component={Login}></Route>
        <Route exact path="/register" component={Register}></Route>
        <Route exact path="/dashboard" component={Dashboard}></Route>
        <Route exact path="/createauction" component={CreateAuction}></Route>
        <Route exact path="/profile" component={Profile}></Route>
        <Route exact path="/searchauction" component={SearchAuction}></Route>
      </Switch>
    </BrowserRouter>
  );
}
