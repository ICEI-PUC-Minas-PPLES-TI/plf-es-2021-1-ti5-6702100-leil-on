import { getUserData } from "../../API";
export default function Dashboard() {
  const userData = getUserData();
  return (
    <div>
      <h1>Dashboard</h1>
    </div>
  );
}
