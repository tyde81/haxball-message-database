import { Room } from "haxball-room";
import axios from "axios";

let room = new Room().createRoom({
  roomName: "q",
  noPlayer: true,
});

room.onPlayerJoin = () => {
  new Room(room).updateAdmins();
};

room.onPlayerLeave = () => {
  new Room(room).updateAdmins();
};

room.onPlayerChat = (player, message) => {
  axios
    .post("http://localhost:4567/user/message", { player, message })
    .then((res) => { console.log(res) });
};
