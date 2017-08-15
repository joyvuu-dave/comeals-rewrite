import React from "react";
import { inject, observer } from "mobx-react";

const CloseButton = inject("store")(
  observer(({ store }) =>
    <button onClick={store.toggleClosed} className="button-dark">
      Open / Close Meal
    </button>
  )
);

export default CloseButton;
