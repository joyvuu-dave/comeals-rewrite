import "../src/styles.css";
import React from "react";
import { render } from "react-dom";
import { Provider } from "mobx-react";
import Cookie from "js-cookie";

import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect
} from "react-router-dom";

import { DataStore } from "../stores/data_store";
import MealsEdit from "../components/meals/edit";
import Calendar from "../components/calendar/show";
import ResidentsLogin from "../components/residents/login";

import ScrollToTop from "../components/app/scroll_to_top";

document.addEventListener("DOMContentLoaded", () => {
  const store = DataStore.create();

  window.addEventListener("load", function() {
    function updateOnlineStatus(event) {
      if (navigator.onLine) {
        console.log(`back online at ${new Date().toLocaleTimeString()}`);
        store.setIsOnline(true);
        if (store.meal && store.meal.id) {
          store.loadDataAsync();
        }
        if (Cookie.get("community_id") !== "undefined") {
          store.loadMonthAsync();
        }
      } else {
        console.log(`offline at ${new Date().toLocaleTimeString()}`);
        store.setIsOnline(false);
      }
    }

    window.addEventListener("online", updateOnlineStatus);
    window.addEventListener("offline", updateOnlineStatus);
  });

  render(
    <Provider store={store}>
      <Router>
        <ScrollToTop>
          <Switch>
            <Route
              exact
              strict
              path="/:url*"
              render={props => <Redirect to={`${props.location.pathname}/`} />}
            />
            <Route
              path="/calendar/:type/:date/:modal?/:view?/:id?"
              component={Calendar}
            />
            <Route path="/meals/:id/edit/:history?" component={MealsEdit} />
            <Route path="/:modal?/:token?" component={ResidentsLogin} />
          </Switch>
        </ScrollToTop>
      </Router>
    </Provider>,
    document.getElementById("main")
  );
});