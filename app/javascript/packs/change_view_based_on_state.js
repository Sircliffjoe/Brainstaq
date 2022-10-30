let stateConfiguration = {
  setup: {
    setup: true,
    setup_facilitator: false,
    setup_participant: false,
    conception: false,
    vote: false,
    voting_done: false
  },
  conception: {
    setup: false,
    setup_facilitator: false,
    setup_participant: false,
    conception: true,
    vote: false,
    voting_done: false
  },
  vote: {
    setup: false,
    setup_facilitator: false,
    setup_participant: false,
    conception: false,
    vote: true,
    voting_done: false
  },
  voting_done: {
    setup: false,
    setup_facilitator: false,
    setup_participant: false,
    conception: false,
    vote: false,
    voting_done: true
  }
}

changeView = function (state) {
  configuration = stateConfiguration[state]
  for (const [key, value] of Object.entries(configuration)) {
    document.getElementById(key).style.display = value ? 'block' : 'none';
  }

  if (typeof brainstormStore.state === 'undefined' || brainstormStore.state === 'setup') {

    document.querySelector("#setup_participant").style.display = currentUser.facilitator == "false" ? "block" : "none"
    document.querySelector("#setup_facilitator").style.display = currentUser.facilitator == "true" ? "block" : "none"
  }

  if (state == "voting_done") {
    document.getElementById("notice").innerHTML = '<div class="bg-greeny fade-out inset-x-0 fixed text-white text-center py-4 z-50 font-bold my-shadow"><span></span></div>'
  }
}

showTimeIsUpModal = function () {
  document.getElementById("time_is_up").classList.remove("hidden");
}

fillStarsWithUserVotes = function () {
  currentUser.votesCastIdeas.forEach((id) => {
    let elements = document.getElementsByClassName(`star-concept-${id}`)
    Array.from(elements).forEach((element) => element.setAttribute("fill", "#312783"))
  })

  currentUser.votesCastIdeaBuilds.forEach((id) => {
    let elements = document.getElementsByClassName(`star-concept-build-${id}`)
    Array.from(elements).forEach((element) => element.setAttribute("fill", "#312783"))
  })

  let votesUsed = currentUser.votesCastIdeas.size + currentUser.votesCastIdeaBuilds.size
  let stars = document.getElementsByClassName("starVoteFill")
  
  for (let i = 0; i < votesUsed; i++) {
    stars[i].setAttribute("fill", "312783")
  }
}

changeHeadlineAccordingToVotesLeft = function (votesCast, maxVotesPerUser) {
  if (votesCast >= maxVotesPerUser) {
    document.getElementById("votingHeadline").textContent = "No votes left!"
  }
  else if (votesCast < maxVotesPerUser) {
    document.getElementById("votingHeadline").textContent = "Vote on your favourite concepts"
  }
}

setAndChangeBrainstormState = function (state) {
  brainstormStore.state = state;
  changeView(state);
}

removeNameListUserIdIfUserIsFacilitator = function () {
  if (currentUser.facilitator == "true") {
    let userNameElement = document.getElementById(`name-list-user-id-${currentUser.id}`);
    userNameElement.remove();
  }
}
