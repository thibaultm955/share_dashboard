import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'count' ];

  connect() {
    console.log(this.countTarget);
  }

  connect() {
    console.log("controller connected !");
    $('.select2').on('select2:select', (e) => this.fetchPlans(e) );
 }

 fetchPlans = (e) => {


    console.log(e.target.value)
 
  }

  refresh() {
    fetch('/portfolios', { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
      });
  }
}