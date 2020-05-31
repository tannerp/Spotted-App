import {Table, Column, Model, HasMany, PrimaryKey, CreatedAt, UpdatedAt,  ForeignKey, AutoIncrement} from 'sequelize-typescript';
import { UUID } from 'aws-sdk/clients/inspector';
import {User} from '../../users/models/User';

@Table
export class Post extends Model<Post> {
  
  @ForeignKey(() => User)
  @Column
  user_email: String;

  @Column
  public title!: string;

  @Column
  public content!: string; // for nullable fields

  @Column
  @CreatedAt
  public createdAt: Date = new Date();

  @Column
  @UpdatedAt
  public updatedAt: Date = new Date();

  short() {
    this.title;
  }
}