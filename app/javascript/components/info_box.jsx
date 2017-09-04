import React from "react";
import { inject, observer } from "mobx-react";
import Extras from "./extras";
import CloseButton from "./close_button";

const styles = {
  main: {
    border: "0.5px solid",
    gridArea: "a2"
  }
};

const InfoBox = inject("store")(
  observer(({ store }) => (
    <div className="offwhite button-border-radius" style={styles.main}>
      <div className="title flex space-between">
        <h2>Signed Up</h2>
        <CloseButton />
      </div>
      <div className="flex nowrap space-between">
        <h4 className="info-circle">
          <div>Total</div>
          <div>{store.attendeesCount}</div>
        </h4>
        <h4 className="info-circle">
          <div>Veg</div>
          <div>{store.vegetarianCount}</div>
        </h4>
        <h4 className="info-circle">
          <div>Late</div>
          <div>{store.lateCount}</div>
        </h4>
        <Extras />
      </div>
    </div>
  ))
);

export default InfoBox;
