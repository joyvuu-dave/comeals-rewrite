import React from "react";
import { inject, observer } from "mobx-react";

const CloseButton = inject("store")(
  observer(
    class CloseButton extends React.Component {
      buttonClass() {
        if (this.props.store.isLoading) {
          return "button-dark button-loader";
        }

        if (this.props.store.meal.closed) {
          return "button-danger";
        } else {
          return "button-success";
        }
      }

      render() {
        const store = this.props.store;
        const meal = this.props.store.meal;

        return (
          <button
            onClick={store.toggleClosed}
            className={this.buttonClass()}
            disabled={meal.reconciled}
          >
            Open / Close Meal
          </button>
        );
      }
    }
  )
);

export default CloseButton;
