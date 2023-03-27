import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["answer"]

  selectAnswer(event) {
    let questionId = this.element.id.split("_")[1]
    let answerId = this.answerValue
    fetch(`/quiz/check_answer?question_id=${questionId}&answer_id=${answerId}`, {
      method: "POST",
    })
  }

  get answerValue() {
    return this.answerTarget.querySelector("input[type='radio']:checked").value
  }
}